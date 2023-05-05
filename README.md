# Flashes
Flashes is a collection of Yolks and Eggs for Pterodactyl, organized in this repository, 
with Docker images generated automatically using GitHub Actions.

## Important
All our image primarily target <b>linux/arm64</b> systems. 
If you build the images yourself, they may also work on other systems but this is not a scenario we intended to use the images for.
This may change in the future, but currently all our images are build for <b>arm64</b>.

## Project Structure
Our repository includes Eggs and Yolks for different games, with a directory structure similar to this:
```
games
┗ <game>
  ┗ <variant>
    ┣ image
    ┃ ┣ Dockerfile
    ┃ ┣ entrypoint.sh
    ┃ ┗ <other files>
    ┣ egg.json
    ┗ install.sh
```

The resulting image tag follows this pattern:
```
ghcr.io/team-flashbang/flashes/games/<game>:<variant>
```

The image directory includes a `Dockerfile` for the corresponding Egg, and may include other files required by the Dockerfile, 
such as an `entrypoint.sh` script.

The `egg.json` file contains the Egg configuration and can be imported directly into a Pterodactyl installation.

The optional `install.sh` file contains a copy of the installation script that is in the `egg.json` file,
and can be used for local testing and easier maintenance.

## Contributing
We welcome contributions to improve this project. To contribute, please follow these steps:

1. Fork the repository.
2. Create a branch with a descriptive name for your feature or bugfix, such as feature/super-cool-feature.
3. Submit a pull request.
4. Profit!

## License
This project is distributed under the GNU GPL-3.0 license. For more information, please refer to the `LICENSE` file.