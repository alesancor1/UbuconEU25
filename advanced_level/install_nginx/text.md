Now that you've packed a basic rock with a static `index.html` file, it’s time to build something more powerful: a rock that **serves web traffic using NGINX**.

In this step, you'll modify your `rockcraft.yaml` to install NGINX and configure it to serve your HTML content.

---

## 📝 Instructions

You’ll now enhance your rock to run NGINX and serve the HTML file from the correct directory.

Here’s what you need to do:

1. **Install NGINX** in your rock by adding the `nginx` package.
2. **Include the `nginx.conf`** file (already provided, check with `ls`) in your rock and ensure it's placed under `/etc/nginx/conf.d/`.
3. **Move your `index.html`** from the root directory to `/var/www/html/`, where NGINX expects static content to be.
4. **Add a new [service](https://documentation.ubuntu.com/rockcraft/en/latest/reference/rockcraft.yaml/#services)** to make nginx the rock entrypoint:
    * The service should run this command: `nginx -g 'daemon off;'`.
    * The service type should be `replace`
    * The service should run at `startup`

> **Hint:** Use the `organize` field (see the docs [here](https://documentation.ubuntu.com/rockcraft/en/latest/common/craft-parts/reference/part_properties/#organize)) in your part to map local file paths to their intended locations inside the rock.


## ✅ Test Your Rock

After updating `rockcraft.yaml`, build your rock again:

```bash
rockcraft pack
```

Then import and run your rock:

```bash
skopeo-copy <your-rock-name>
docker run --rm -d -p 8080:80 --name hello-nginx "<your-rock-name>:latest"
```

Now curl `http://localhost:8080` and confirm that your HTML page is being served by NGINX!

```bash
curl http://localhost:8080
```

Remember to stop your container:

```bash
docker stop hello-nginx
```

## 🎯 Bonus Points: Slim Down Your Rock

> If you want to compare the sizes afterwards, make sure to rename your rock to `chiseled-<name>` or increase the version number to avoid overwritting when copying it to docker daemon!

#### Make your rock baseless

Use the `bare` base along with a `build-base` to greatly reduce the size of your rock. Avoid adding any unnecessary Ubuntu dependencies!

#### Slice your packages with chisel

Use **Chisel slices** to avoid pulling in unnecessary system packages.

Check for available nginx slices at [chisel-releases repo](https://github.com/canonical/chisel-releases) and select the appropiate slice to install!

> Note that nginx will need some **base files** to work (`/var/*`, `/home/*` and `etc/passwd`). Find the SDF for them!

---

Now test your rock again, you can run `docker image ls` to see the difference in size!
