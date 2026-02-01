# Security Policy

## Reporting a Vulnerability

**⚠️ IMPORTANT: Do NOT open a public issue or pull request for security vulnerabilities**

If you discover a security vulnerability in this project, please report it responsibly by emailing:

📧 **github@jordancodes.com**

Please include:

- Description of the vulnerability
- Location in the code (file, line number, or configuration)
- Steps to reproduce the issue
- Potential impact and severity
- Suggested fix (if you have one)

## Response Timeline

- **Initial Response**: Within 48 hours of report
- **Acknowledgment**: We will confirm receipt and provide a timeline for a fix
- **Fix and Release**: We aim to release security patches within 7-14 days
- **Disclosure**: Once patched, we will publicly disclose the vulnerability (with your permission)

## Security Considerations

### For Container Deployment

When deploying this Samba container, please consider:

1. **Network Security**
   - Run only on trusted networks
   - Adjust `hosts allow` in `smb.conf` to restrict access
   - Use VPN or firewall rules to limit SMB port access (445/tcp)
   - Avoid exposing the container directly to the internet

2. **Authentication**
   - Use **strong, unique passwords** for SMB users
   - Store credentials securely (use Docker secrets or environment files, not hardcoded)
   - Never commit `.env` files with real passwords to version control
   - Rotate passwords regularly

3. **Protocol Security**
   - This container enforces SMB3.11 minimum protocol version
   - Encryption is required (`smb encrypt = required`)
   - NTLM authentication is disabled for improved security

4. **Container Security**
   - Keep Docker and your host OS updated
   - Run containers with minimal required privileges
   - Use read-only mounts where appropriate for shared folders
   - Monitor container logs for suspicious activity

5. **Data Protection**
   - Ensure proper file permissions on shared volumes
   - Regular backups of shared data
   - Consider encrypting sensitive data at rest

### Known Security Features

✅ SMB 3.11 minimum protocol enforcement
✅ Mandatory encryption
✅ NTLM auth disabled
✅ IP-based access restrictions
✅ User authentication required for all shares
✅ Proper permission handling

## Security Updates

- We monitor security advisories for Samba and Debian
- Docker image updates are released for critical security patches
- Subscribe to releases to be notified of security updates

## Responsible Disclosure

We practice responsible disclosure:

1. We will not publicly disclose vulnerabilities until a patch is available
2. We will credit the researcher (unless requested otherwise)
3. We work collaboratively to understand and resolve issues

## Best Practices for Users

- Keep your Samba container image updated
- Regularly review and audit `smb.conf` settings
- Monitor access logs in `/var/log/samba/`
- Test configuration changes in non-production environments first
- Use strong, unique passwords
- Implement network-level access controls

## Security Advisories

For security updates and advisories:

- Watch this repository for releases
- Check [Samba Security](https://www.samba.org/samba/security/) regularly
- Subscribe to [Debian Security](https://www.debian.org/security/) for base image updates

## Escalation

If your vulnerability report requires escalation or additional security review, we will provide contact information for our security team in our response email.

---

**Thank you for helping keep this project secure!** 🛡️
