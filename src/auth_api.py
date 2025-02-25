# api_auth.py
import os
from functools import wraps
from flask import request, jsonify

# خواندن API key از متغیرهای محیطی (یا می‌توانید مستقیماً در اینجا تعریف کنید)
API_KEYS = os.environ.get('API_KEYS', 'default_key1,default_key2').split(',')

def require_api_key(f):
    """
    دیکوراتور برای بررسی API key در هدر درخواست
    """
    @wraps(f)
    def decorated_function(*args, **kwargs):
        api_key = request.headers.get('X-API-Key')
        
        # بررسی وجود API key در هدر درخواست
        if not api_key:
            return jsonify({"error": "API key is missing"}), 401
        
        # بررسی اعتبار API key
        if not API_KEYS or api_key not in API_KEYS:
            return jsonify({"error": "Invalid API key"}), 403
            
        return f(*args, **kwargs)
    return decorated_function

# می‌توانید دیکوراتورهای دیگر نیز اضافه کنید
def require_permission(permission_level):
    """
    دیکوراتور برای بررسی سطح دسترسی API key
    """
    def decorator(f):
        @wraps(f)
        def decorated_function(*args, **kwargs):
            api_key = request.headers.get('X-API-Key')
            
            if not api_key:
                return jsonify({"error": "API key is missing"}), 401
            
            # در اینجا می‌توانید مپینگ سطوح دسترسی را تعریف کنید
            # در یک محیط واقعی بهتر است این اطلاعات را در یک دیتابیس نگهداری کنید
            api_permissions = {
                "default_key1": "admin",
                "default_key2": "read"
            }
            
            if api_key not in api_permissions:
                return jsonify({"error": "Invalid API key"}), 403
                
            user_permission = api_permissions.get(api_key)
            
            # بررسی سطح دسترسی
            if permission_level == "admin" and user_permission != "admin":
                return jsonify({"error": "Insufficient permissions"}), 403
                
            if permission_level == "write" and user_permission not in ["admin", "write"]:
                return jsonify({"error": "Insufficient permissions"}), 403
                
            return f(*args, **kwargs)
        return decorated_function
    return decorator
