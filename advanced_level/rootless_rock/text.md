You're now serving content with NGINX inside your rock, awesome! But there’s one more best practice to follow: **running your container without root privileges**.

This step will guide you through modifying your rock to **run NGINX as a non-root user**, using Rockcraft’s built-in rootless support.

---

## 🧐 Why Rootless?

In the context of OCI images, **rootless** means the container’s main process doesn’t run as the `root` user inside the container. This improves security by minimizing the risk in case your app or server (like NGINX) is compromised.

Rockcraft provides a convenient user named `_daemon_` (UID:GID `584792:584792`) for exactly this use case.

---

## 📝 Instructions

To make your NGINX rock rootless, you’ll need to:

1. **Use the [run-user](https://ubuntu.com/containers/rockcraft/docs/latest/reference/rockcraft-yaml/#run-user) field** to set the default user for the container to `_daemon_`.
2. **Change ownership** of any directories or files that NGINX needs to write to or serve from so that they are owned by the `_daemon_` user. These are:
    * `/run`
    * `/var/lib/nginx` 
    * `/var/www/html`
    * `/var/log/nginx`
    * `/etc/nginx`
3. **Override the `prime` step** in your `rockcraft.yaml` to perform these `chown` operations. 
    * Use the `override-prime` field for this. See the [docs](https://ubuntu.com/containers/rockcraft/docs/latest/reference/rockcraft-yaml/#override-prime)

> You can get more context about rockcraft lifecycle (pull, overlay, build, stage, prime) in the [docs](https://ubuntu.com/containers/rockcraft/docs/latest/common/craft-parts/explanation/lifecycle/).

---

#### ✍️ Hint: How to Override a lifecycle step

You’ll need to add a `override-prime` section to your part, like this:

```yaml
parts:
    my-part:
        ...

        override-prime: |
            # Let rockcraft manage any operations prior to your override commands
            craftctl default

            # Change ownerships of the files here. CRAFT_PRIME is required to tell rockcraft where the files are.
            chown -R <UID>:<GID> \
                ${CRAFT_PRIME}/<directory> \
                ${CRAFT_PRIME}/<directory> \
                ...
```

## ✅ Test Your Rootless Rock

Rebuild and test your rock:

```bash
rockcraft pack
skopeo-copy <your-rock-name>
docker run --rm -d -p 8080:80 --name hello-nginx "<your-rock-name>:<version>"
```

You should be able to run curl and check the file being served by your rock. Then verify that the container is running, and optionally inspect it to confirm it’s running as the non-root user:

```bash
docker exec -it <container-id> whoami
```

You should see `_daemon_`.

> If your container is chiselled you will not be able to run `whoami`, instead, you can check the contents of your image using external tools like [dive](https://github.com/wagoodman/dive)

Remember to stop your container:

```bash
docker stop hello-nginx
```