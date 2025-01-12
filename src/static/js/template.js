document.addEventListener("DOMContentLoaded", function () {
  if (!window.peerInfo) {
    console.error("peerInfo is not defined.");
    return;
  }

  const { peerName, configFile, token } = window.peerInfo;

  if (!peerName || !configFile || !token) {
    console.error("Missing required parameters for peer details:", window.peerInfo);
    return;
  }

  console.log("Peer Info:", window.peerInfo);

  const peerNameElem = document.getElementById("peer-name");
  const dataLimitElem = document.getElementById("data-limit");
  const remainingAmountLbl = document.getElementById("remaining-amount-label");
  const expiryDateElem = document.getElementById("expiry-date");
  const dataProgressBar = document.getElementById("data-progress");
  const remainingProgress = document.getElementById("remaining-progress");
  const expiryProgress = document.getElementById("expiry-progress");
  const refreshBtn = document.getElementById("refresh-btn");
  const qrCodeBtn = document.getElementById("qr-code-btn");
  const downloadConfigBtn = document.getElementById("download-config-btn");
  const qrModal = document.getElementById("qr-modal");
  const qrImage = document.getElementById("qr-image");
  const closeModal = document.getElementById("close-modal");
  const clientStatusLabel = document.getElementById("client-status-label");

  function formatHumanReadableSize(sizeStr) {
    const match = /([\d.]+)\s*(\w+)/.exec(sizeStr);
    if (!match) {
      return "نامشخص";
    }
    const value = match[1];
    const unit = match[2];
    return `${value} ${unit}`;
  }

  function parseExpiryHuman(expiryHuman) {
  const daysMatch = /(\d+)\s*روز/.exec(expiryHuman);
  const hoursMatch = /(\d+)\s*ساعت/.exec(expiryHuman);
  const minutesMatch = /(\d+)\s*دقیقه/.exec(expiryHuman);

  const days = daysMatch ? parseInt(daysMatch[1], 10) : 0;
  const hours = hoursMatch ? parseInt(hoursMatch[1], 10) : 0;
  const minutes = minutesMatch ? parseInt(minutesMatch[1], 10) : 0;

  return { days, hours, minutes };
}

function formatRemainingTime({ days, hours, minutes }) {
  let formattedTime = "";

  if (days > 0) {
    formattedTime += `${days} روز`;
  } else {
    formattedTime += "0 روز";
  }

  if (hours > 0) {
    if (formattedTime) formattedTime += "، ";
    formattedTime += `${hours} ساعت`;
  } else {
    if (formattedTime) formattedTime += "، ";
    formattedTime += "0 ساعت";
  }

  if (minutes > 0) {
    if (formattedTime) formattedTime += "، ";
    formattedTime += `${minutes} دقیقه`;
  } else {
    if (formattedTime) formattedTime += "، ";
    formattedTime += "0 دقیقه";
  }

  return formattedTime;
}


function fetchPeerDetails() {
  const url = `/api/peer-detailz?peer_name=${encodeURIComponent(peerName)}`
            + `&config_file=${encodeURIComponent(configFile)}`
            + `&token=${encodeURIComponent(token)}`;

  fetch(url)
    .then(response => response.json())
    .then(data => {
      if (data.error) {
        alert(data.error);
        return;
      }

      peerNameElem.textContent = data.peer_name || "نامشخص";
      dataLimitElem.textContent = formatHumanReadableSize(data.limit_human || "0 MiB");
      remainingAmountLbl.textContent = formatHumanReadableSize(data.remaining_human || "0 MiB");

      const { days, hours, minutes } = parseExpiryHuman(data.expiry_human || "");
      expiryDateElem.textContent = formatRemainingTime({ days, hours, minutes });

      const remainingMinutes = days * 24 * 60 + hours * 60 + minutes;
      const totalMinutes = 30 * 24 * 60; 
      const expiryRatio = (remainingMinutes / totalMinutes) * 100;
      expiryProgress.style.width = `${Math.min(100, expiryRatio)}%`;

      const remainingMatch = /([\d.]+)/.exec(data.remaining_human || "0");
      const remainingVal = remainingMatch ? parseFloat(remainingMatch[1]) : 0;

      const limitMatch = /([\d.]+)/.exec(data.limit_human || "0");
      const numericLimit = limitMatch ? parseFloat(limitMatch[1]) : 1;
      const remainingRatio = (numericLimit > 0) ? (remainingVal / numericLimit) * 100 : 0;
      remainingProgress.style.width = `${Math.min(100, remainingRatio)}%`;

      fetch(`/api/search-peers?query=${encodeURIComponent(peerName)}`)
        .then(statusResponse => statusResponse.json())
        .then(statusData => {
          const peer = statusData.peers.find(p => p.peer_name === peerName);
          if (peer && !peer.monitor_blocked && !peer.expiry_blocked) {
            clientStatusLabel.textContent = "فعال";
            clientStatusLabel.style.color = "#4CAF50";
          } else {
            clientStatusLabel.textContent = "غیرفعال";
            clientStatusLabel.style.color = "#F44336";
          }
        });
    })
    .catch(error => {
      console.error("Error in fetching peer details:", error);
    });
}

  refreshBtn.addEventListener("click", fetchPeerDetails);
  qrCodeBtn.addEventListener("click", function () {
    const url = `/api/qr-code?peerName=${encodeURIComponent(peerName)}&config=${encodeURIComponent(configFile)}`;
    fetch(url)
      .then(response => response.json())
      .then(data => {
        if (data.error) {
          alert(data.error);
          return;
        }
        qrImage.src = data.qr_code;
        qrModal.style.display = "flex";
      });
  });
  downloadConfigBtn.addEventListener("click", function () {
    const url = `/api/download-peer-config?peerName=${encodeURIComponent(peerName)}&config=${encodeURIComponent(configFile)}`;
    window.open(url, "_blank");
  });
  closeModal.addEventListener("click", () => {
    qrModal.style.display = "none";
  });

  fetchPeerDetails();
  setInterval(fetchPeerDetails, 5000);
});
