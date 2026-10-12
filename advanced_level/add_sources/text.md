In this step, you'll define a `rockcraft.yaml` file that includes a simple static file—`index.html`—inside your rock. This is a foundational way to package files using Rockcraft.

## 📝 Instructions

You’re going to create a new `rockcraft.yaml` file from scratch.

To get your rock set up correctly, you’ll need to:

1. **Add metadata** that describes your rock, such as its name, version, and a short summary.
2. **Specify a base**—this tells Rockcraft which base image to build your rock from.
3. **Define the platform(s)** your rock should support, such as `amd64`.
4. **Create a part** that includes your `index.html` file (already provided, check with `ls`). You’ll use the [dump plugin](https://ubuntu.com/containers/rockcraft/docs/latest/common/craft-parts/reference/plugins/dump_plugin/) to include local files, and make sure to [stage](https://ubuntu.com/containers/rockcraft/docs/latest/reference/rockcraft-yaml/#stage) the `index.html` so it's included in the final rock.


### Take Into Account

* You can use `rockcraft init` to initialize a new rockcraft project.

* You can use `nano`, `vim`, or any text editor to create and edit your `rockcraft.yaml` file.

--- 

Once done, you’ll be ready to build a rock that serves your `index.html`!


## ✅ Testing your rock

Once your `rockcraft.yaml` is ready, pack your rock with:

```bash
rockcraft pack
```

Then import your rock with:

```bash
skopeo-copy <your-rock-name>
```

Run your image with docker and check that the `index.html` file is there:

```bash
docker run --rm "<your-rock-name>:<version>" exec cat /index.html"
```

Once your rock is packed and working, check the result and jump to the next step!
