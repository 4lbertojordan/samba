# Contributing to Samba Docker

Thank you for your interest in contributing to this project! This document provides guidelines and instructions for contributing.

## Code of Conduct

Be respectful and constructive in all interactions. We are committed to maintaining a welcoming and inclusive environment.

## How to Contribute

### Reporting Issues

If you find a bug or have a feature request, please open an issue using the appropriate template:

1. Go to the [Issues](https://github.com/4lbertojordan/samba/issues) tab
2. Click "New Issue"
3. Select the appropriate template (Bug Report, Feature Request, or General Question)
4. Fill in all relevant information
5. Submit the issue

### Submitting Pull Requests

1. **Fork the repository** and create a branch from `main`

   ```bash
   git clone https://github.com/4lbertojordan/samba
   cd samba
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes**
   - Update the Dockerfile if needed
   - Modify `smb.conf` for configuration changes
   - Update `entrypoint.sh` for startup script changes
   - Update `README.md` with documentation

3. **Test your changes**
   - Build the image locally

   ```bash
   docker build -f smb.dockerfile -t samba:test .
   ```

   - Test with Docker Compose or Docker Run
   - Verify the container starts and Samba responds correctly

4. **Open a Pull Request**
   - Provide a clear description of the changes
   - Reference any related issues
   - Include screenshots or logs if relevant

**Types:**

- `feat:` A new feature
- `fix:` A bug fix
- `docs:` Documentation changes
- `style:` Code style changes (formatting, missing semicolons, etc)
- `refactor:` Code refactoring

### Documentation

- Update [README.md](README.md) for user-facing changes
- Add comments in code for complex logic
- Update environment variables table if adding new variables
- Document security implications of changes

### File Structure Guidelines

- **smb.conf**: Samba server configuration
- **entrypoint.sh**: Container startup script and user/group setup
- **smb.dockerfile**: Docker image definition
- **docker-compose.yml**: Example Docker Compose configuration
- **environment.txt**: Example environment variables

## Development Tips

### Local Testing

Test the full workflow:

```bash
# Build the image
docker build -f smb.dockerfile -t samba:test .

# Run with Docker Compose
docker-compose up -d

# Check logs
docker logs -f samba_server

# Test SMB connection
smbclient -L //localhost -U test_user
```

### Configuration Changes

When modifying `smb.conf`:

- Ensure compatibility with Windows, macOS, and Linux clients
- Test with current clients if possible
- Comment your configuration sections
- Avoid breaking existing share definitions

### Environment Variables

New environment variables should:

- Be documented in [README.md](README.md)
- Have sensible defaults in [entrypoint.sh](entrypoint.sh)
- Be clearly named and prefixed with `SMB_` when possible

## Areas for Contribution

- **Documentation**: Improve README, add examples, fix typos
- **Features**: Enhanced Samba configuration options
- **Security**: Report vulnerabilities responsibly
- **Compatibility**: Improve support for different systems
- **Performance**: Optimization suggestions

## Security

If you discover a security vulnerability, please email the maintainer directly instead of using the issue tracker. Do not publicly disclose the vulnerability until it has been addressed.

## Questions?

- Check existing [issues](https://github.com/4lbertojordan/samba/issues)
- Review the [README.md](README.md) for usage documentation
- Open a general question issue if needed

Thank you for contributing! 🎉
