# Packwiz GitHub Action

A dead simple GitHub Action that loads and runs **[packwiz]** in your workflows.

This action provides the [packwiz] binaries for all 3 major systems. Simply pass the arguments you want to run with `packwiz` to the `args` input, and the action will take care of the rest!

```yaml
- name: Package Modpack
  uses: hudsonm62/packwiz-action@v1
  with:
    args: modrinth export
```

- [See it in Action!](https://github.com/hudsonm62/packwiz-action/actions/workflows/test-action.yml) 🥁

## License

This repository is licensed under the MIT License - See the [LICENSE](LICENSE) file for details.

packwiz binaries are provided from the [`nightly.link` mirror](https://nightly.link/packwiz/packwiz/workflows/go/main). 'packwiz' is licensed under the MIT License - See the [packwiz LICENSE](https://github.com/packwiz/packwiz/blob/main/LICENSE)

[packwiz]: https://github.com/packwiz/packwiz
