#!/bin/bash
set -e

if [ -n "$TZ" ]; then
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
fi


USER_NAME=${SMB_USER:-jordan}
USER_UID=${SMB_UID:-1000}
GROUP_NAME=${SMB_GROUP:-home}
GROUP_GID=${SMB_GID:-1000}

if ! getent group "$GROUP_NAME" >/dev/null; then
    echo "Creating group: $GROUP_NAME ($GROUP_GID)"
    groupadd -g "$GROUP_GID" "$GROUP_NAME"
fi

if ! id -u "$USER_NAME" >/dev/null 2>&1; then
    echo "Creating system user: $USER_NAME ($USER_UID)"
    useradd -u "$USER_UID" -g "$GROUP_GID" -M -s /sbin/nologin "$USER_NAME"
fi

echo "Verifying Samba directory structure..."
mkdir -p /var/lib/samba/private
mkdir -p /var/log/samba
mkdir -p /var/run/samba


chmod 700 /var/lib/samba/private

if [ -n "$SMB_PASSWORD" ]; then
    if ! pdbedit -L >/dev/null 2>&1; then
        echo "New or corrupted user database. Initializing..."
    fi

    if ! pdbedit -L | grep -q "^$USER_NAME:"; then
        echo "Initializing Samba user: $USER_NAME"
        (echo "$SMB_PASSWORD"; echo "$SMB_PASSWORD") | smbpasswd -a -s "$USER_NAME"
    else
        echo "Updating password for: $USER_NAME"
        (echo "$SMB_PASSWORD"; echo "$SMB_PASSWORD") | smbpasswd -s "$USER_NAME"
    fi
    smbpasswd -e "$USER_NAME"
fi

echo "Starting Samba..."
exec "$@"