# Encryption Setup

This repository uses [age](https://github.com/FiloSottile/age) encryption to securely store sensitive files like SSH keys in a public repository.

## Why age?

- **Modern cryptography**: Uses X25519, ChaCha20-Poly1305, and BLAKE2b
- **Quantum-resistant**: While not fully post-quantum, it's more resistant than RSA
- **Simple**: No web of trust, key management is straightforward
- **Chezmoi integration**: Native support in chezmoi

## Initial Setup (First Machine)

1. Install chezmoi and apply dotfiles:
   ```bash
   chezmoi init --apply programmatio
   ```

2. The setup scripts will automatically:
   - Generate an age key pair
   - Generate SSH keys
   - Configure chezmoi for encryption

3. **IMPORTANT**: Backup your age key (`~/.config/age/key.txt`) securely!

## Setup on Additional Machines

1. Copy your age key from your secure backup to `~/.config/age/key.txt`
   
2. Set proper permissions:
   ```bash
   chmod 700 ~/.config/age
   chmod 600 ~/.config/age/key.txt
   ```

3. Apply dotfiles:
   ```bash
   chezmoi init --apply programmatio
   ```

## Managing Encrypted Files

### Add an encrypted file:
```bash
chezmoi add --encrypt ~/.ssh/id_ed25519
```

### Edit an encrypted file:
```bash
chezmoi edit ~/.ssh/id_ed25519
```

### View encrypted files in the source:
```bash
chezmoi cd
ls -la | grep encrypted
```

## Security Notes

1. **Never commit your age private key** to the repository
2. Store your age key backup in a password manager or encrypted cloud storage
3. The age public key in the chezmoi config is safe to share
4. Encrypted files in the repo are safe even in a public repository

## Troubleshooting

If you get decryption errors:
1. Ensure your age key is at `~/.config/age/key.txt`
2. Check permissions: `chmod 600 ~/.config/age/key.txt`
3. Verify the age recipient in `~/.config/chezmoi/chezmoi.toml` matches your key