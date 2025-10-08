# libfridge

A simple, hassle-free storage library to keep your data fresh.
Ready out of the box, and comprehensive for vala newcomers. This library primarily contains the three following objects:

- json_storage
- string_storage
- byte_storage

all three are meant to represent a storage file saved on the disk, and intended to contain a type of data. Simply declare:

```
var mystorage = new Fridge.json_storage();
```

Or any variant depending what you want to store... And you are good to go!
Save by doing:

```
mystorage.content = thing_to_save;
```

Access it by doing:

```
var thing_to_load = mystorage.content;
```

Features:
- [x] Smart instancing: Each instance is its own distinct file 
- [x] Cache: By default a cache lets you access content faster
- [x] Optional error handling: You can connect to the error() signal


Wishlist of features:
- [] More agressive trying to load/save in case of errors
- [] Optional SQL storage i think?


## Add to your flatpak project

Simply copy the in your manifest before your app sources:

```
  - name: libfridge
    buildsystem: meson
    sources:
      - type: git
        url: https://github.com/vala-community/libfridge.git
        tag: 0.0.1
        commit: [NOT DONE YET]
        x-checker-data:
          type: git
          tag-pattern: '^([\d.]+)$'
```

By default json_storage is included. If you do not use it, and wish to skip having a json dependency, you can add immediately after the buildsystem line:

```
    config-opts:
      - -Denable_json=false
```




## Build Instructions

First, setup the build directory by running the following command in the project root:

```
meson setup build --prefix=/usr
```

Now change to the `build` directory (`cd build`) for the following commands:

Build libfridge:

```
ninja
```

To install libfridge:

```
ninja install
```

## Documentation

By default, documentation is built by default using [`valadoc`](https://docs.vala.dev/developer-guides/documentation/valadoc-guide.html)

If you would not like to generate documentation for this project, pass the additional `-Denable_valadoc=false` flag to meson then run `ninja` as before.

If you haven't created the build directory, in the project root run:

```
meson setup build --prefix=/usr -Denable_valadoc=false
```

However, if you have already created the build directory, you can run the following command inside the build directory:

```
meson configure -Denable_valadoc=false
```

To enable valadoc documentation generation again, perform the same commands again but replace `false` in `-Denable_valadoc=` with `true`.
