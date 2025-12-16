"""
Authentication Module for Multitudes.

Provides passphrase-based authentication with JWT tokens for multi-user testing.
"""

import os
import secrets
import hashlib
from datetime import datetime, timedelta
from typing import Optional, Dict

from jose import JWTError, jwt
from passlib.context import CryptContext


# Configuration
SECRET_KEY = os.getenv("JWT_SECRET_KEY", secrets.token_urlsafe(32))
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 60 * 24 * 30  # 30 days


# Password hashing context
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")


def hash_passphrase(passphrase: str) -> str:
    """
    Hash a passphrase using bcrypt.
    
    Args:
        passphrase: Plain text passphrase
        
    Returns:
        Hashed passphrase
    """
    return pwd_context.hash(passphrase)


def verify_passphrase(plain_passphrase: str, hashed_passphrase: str) -> bool:
    """
    Verify a passphrase against its hash.
    
    Args:
        plain_passphrase: Plain text passphrase
        hashed_passphrase: Stored hash
        
    Returns:
        True if passphrase matches
    """
    return pwd_context.verify(plain_passphrase, hashed_passphrase)


def create_access_token(data: Dict[str, any], expires_delta: Optional[timedelta] = None) -> str:
    """
    Create a JWT access token.
    
    Args:
        data: Data to encode in token
        expires_delta: Optional expiration time
        
    Returns:
        JWT token string
    """
    to_encode = data.copy()
    
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    
    return encoded_jwt


def decode_access_token(token: str) -> Optional[Dict[str, any]]:
    """
    Decode and verify a JWT token.
    
    Args:
        token: JWT token string
        
    Returns:
        Decoded token data or None if invalid
    """
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        return payload
    except JWTError:
        return None


def generate_user_id_from_passphrase(passphrase: str) -> str:
    """
    Generate a deterministic user ID from a passphrase.
    
    This allows the same passphrase to always map to the same user.
    
    Args:
        passphrase: The passphrase
        
    Returns:
        16-character user ID
    """
    return hashlib.sha256(passphrase.encode()).hexdigest()[:16]


# Predefined passphrases for testing
# In production, these would be generated and distributed securely
PREDEFINED_PASSPHRASES = {
    "purple-monkey-dishwasher": {
        "user_id": "test_user_001",
        "display_name": "Test User 1"
    },
    "correct-horse-battery": {
        "user_id": "test_user_002",
        "display_name": "Test User 2"
    },
    "flying-toaster-banana": {
        "user_id": "test_user_003",
        "display_name": "Test User 3"
    },
    "cosmic-panda-sunrise": {
        "user_id": "test_user_004",
        "display_name": "Test User 4"
    },
    "quantum-dolphin-jazz": {
        "user_id": "test_user_005",
        "display_name": "Test User 5"
    },
}


def get_user_from_passphrase(passphrase: str) -> Optional[Dict[str, str]]:
    """
    Get user info from a predefined passphrase.
    
    Args:
        passphrase: The passphrase to check
        
    Returns:
        User info dict or None if not found
    """
    return PREDEFINED_PASSPHRASES.get(passphrase)


def generate_memorable_passphrase() -> str:
    """
    Generate a memorable passphrase.
    
    Format: adjective-noun-noun
    
    Returns:
        Generated passphrase
    """
    adjectives = [
        "purple", "cosmic", "quantum", "electric", "golden", "silver", 
        "crystal", "ancient", "modern", "swift", "clever", "happy"
    ]
    nouns = [
        "monkey", "panda", "dolphin", "dragon", "phoenix", "tiger",
        "eagle", "wolf", "lion", "bear", "falcon", "otter"
    ]
    things = [
        "sunrise", "moonlight", "thunder", "breeze", "storm", "rainbow",
        "waterfall", "mountain", "ocean", "forest", "desert", "glacier"
    ]
    
    return f"{secrets.choice(adjectives)}-{secrets.choice(nouns)}-{secrets.choice(things)}"
