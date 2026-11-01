# Docker Image Tags Reference

This document describes the Docker image tagging strategy for the vsftpd project.

## Tag Naming Convention

All images use the format: `snowdreamtech/vsftpd:TAG`

Where `TAG` follows these patterns:

- **Variant-specific tags**: `TAG-variant` (e.g., `nightly-alpine`, `3.0.5-alpine`)
- **Default tags** (Debian only): `TAG` (e.g., `nightly`, `latest`, `3.0.5`)

## Supported Registries

All tags are pushed to two registries:

- **DockerHub**: `snowdreamtech/vsftpd:TAG`
- **GitHub Container Registry**: `ghcr.io/snowdreamtech/vsftpd:TAG`

## Tag Scenarios

### 1. Branch Builds (dev/main)

#### Push to `dev` branch

```bash
git push origin dev
```

**Generated tags:**

```
snowdreamtech/vsftpd:dev-alpine
snowdreamtech/vsftpd:dev-debian
snowdreamtech/vsftpd:dev              # ← Debian (default)
snowdreamtech/vsftpd:dev-rocky
```

#### Push to `main` branch

```bash
git push origin main
```

**Generated tags:**

```
snowdreamtech/vsftpd:main-alpine
snowdreamtech/vsftpd:latest-alpine
snowdreamtech/vsftpd:main-debian
snowdreamtech/vsftpd:latest-debian
snowdreamtech/vsftpd:main             # ← Debian (default)
snowdreamtech/vsftpd:latest           # ← Debian (default)
snowdreamtech/vsftpd:main-rocky
snowdreamtech/vsftpd:latest-rocky
```

---

### 2. Release Tags (Semantic Versioning)

#### Alpine Release

```bash
git tag alpine-v3.0.5
git push origin alpine-v3.0.5
```

**Generated tags:**

```
snowdreamtech/vsftpd:3.0.5-alpine
snowdreamtech/vsftpd:latest-alpine
```

#### Debian Release

```bash
git tag debian-v3.0.5
git push origin debian-v3.0.5
```

**Generated tags:**

```
snowdreamtech/vsftpd:3.0.5-debian
snowdreamtech/vsftpd:latest-debian
snowdreamtech/vsftpd:3.0.5           # ← Debian (default)
snowdreamtech/vsftpd:latest           # ← Debian (default)
```

#### Rocky Release

```bash
git tag rocky-v10.1.0
git push origin rocky-v10.1.0
```

**Generated tags:**

```
snowdreamtech/vsftpd:10.1.0-rocky
snowdreamtech/vsftpd:latest-rocky
```

---

### 3. Nightly Builds (Scheduled)

**Trigger:** Automatically every day at 17:00 UTC

**Generated tags:**

```
# Alpine
snowdreamtech/vsftpd:nightly-alpine
snowdreamtech/vsftpd:20260427-alpine

# Debian (with default tags)
snowdreamtech/vsftpd:nightly-debian
snowdreamtech/vsftpd:20260427-debian
snowdreamtech/vsftpd:nightly          # ← Debian (default)
snowdreamtech/vsftpd:20260427         # ← Debian (default)

# Rocky
snowdreamtech/vsftpd:nightly-rocky
snowdreamtech/vsftpd:20260427-rocky
```

---

## Tag Priority

Tags are generated with the following priority (higher number = higher priority):

| Priority | Type | Example Tags | Trigger |
|----------|------|--------------|---------|
| 1000 | Nightly | `nightly`, `nightly-alpine` | Schedule |
| 900 | Date | `20260427`, `20260427-alpine` | Schedule |
| 800 | Version | `3.0.5-alpine`, `3.0.5` | Tag push |
| 600 | Branch | `dev-alpine`, `main-debian` | Branch push |
| 200 | Latest | `latest`, `latest-alpine` | Main/Tag |

---

## Default Variant (Debian)

Debian is designated as the **default variant** (`is_latest: true`), which means:

✅ **Debian gets BOTH suffixed AND unsuffixed tags:**

```
snowdreamtech/vsftpd:nightly-debian   # Variant-specific
snowdreamtech/vsftpd:nightly          # Default (no suffix)

snowdreamtech/vsftpd:3.0.5-debian    # Variant-specific
snowdreamtech/vsftpd:3.0.5           # Default (no suffix)

snowdreamtech/vsftpd:latest-debian    # Variant-specific
snowdreamtech/vsftpd:latest           # Default (no suffix)
```

❌ **Alpine and Rocky get ONLY suffixed tags:**

```
snowdreamtech/vsftpd:nightly-alpine   # Variant-specific only
snowdreamtech/vsftpd:nightly-rocky    # Variant-specific only
```

---

## Usage Examples

### Pull the latest Debian image (default)

```bash
docker pull snowdreamtech/vsftpd:latest
# or
docker pull snowdreamtech/vsftpd:latest-debian
```

### Pull the latest Alpine image

```bash
docker pull snowdreamtech/vsftpd:latest-alpine
```

### Pull the latest Rocky image

```bash
docker pull snowdreamtech/vsftpd:latest-rocky
```

### Pull a specific version

```bash
# Alpine 3.0.5
docker pull snowdreamtech/vsftpd:3.0.5-alpine

# Debian 3.0.5 (two ways)
docker pull snowdreamtech/vsftpd:3.0.5-debian
docker pull snowdreamtech/vsftpd:3.0.5

# Rocky 10.1.0
docker pull snowdreamtech/vsftpd:10.1.0-rocky
```

### Pull nightly builds

```bash
# Alpine nightly
docker pull snowdreamtech/vsftpd:nightly-alpine

# Debian nightly (two ways)
docker pull snowdreamtech/vsftpd:nightly-debian
docker pull snowdreamtech/vsftpd:nightly

# Rocky nightly
docker pull snowdreamtech/vsftpd:nightly-rocky
```

---

## Tag Lifecycle

### Development Flow

```
1. Push to dev → base:dev-alpine, base:dev-debian, base:dev, base:dev-rocky
2. Push to main → base:main-alpine, base:latest-alpine, base:main-debian, base:latest-debian, base:main, base:latest, base:main-rocky, base:latest-rocky
3. Create tag → base:VERSION-variant, base:latest-variant (+ unsuffixed for Debian)
```

### Release Flow (with Release Please)

```
1. Merge PR to main → Release Please creates release PR
2. Merge release PR → Release Please creates tags (alpine-vX.Y.Z, debian-vX.Y.Z, rocky-vX.Y.Z)
3. Tag push triggers build → Images published with version tags
```

---

## Matrix Configuration

The workflow uses a matrix strategy with three variants:

```yaml
matrix:
  include:
    - variant: alpine
      version: "3.0.5"
      is_latest: false

    - variant: debian
      version: "3.0.5"
      is_latest: true    # ← Default variant

    - variant: rocky
      version: "10.1.0"
      is_latest: false
```

Only the variant with `is_latest: true` receives unsuffixed tags.

---

## Metadata Action Configuration

The key configuration that enables this tagging strategy:

```yaml
images: |
  name=snowdreamtech/vsftpd,enable=true
  name=ghcr.io/snowdreamtech/vsftpd,enable=true
flavor: |
  latest=false
  prefix=
  suffix=-${{ matrix.variant }}  # ← Adds variant suffix to all tags
```

For Debian (is_latest), additional rules generate unsuffixed tags:

```yaml
type=raw,enable=${{ matrix.is_latest }},priority=1000,prefix=,suffix=,pattern=nightly
```

This creates both `nightly-debian` (from flavor suffix) and `nightly` (from this rule).
