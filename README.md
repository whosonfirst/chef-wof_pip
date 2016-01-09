wof_pip
=======
Run the WOF Point-In-Polygon server and downloads data determined from a set of metafiles.

Usage
-----

#### wof_pip::default

Just include `wof_pip` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[wof_pip]"
  ]
}
```

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: grant@mapzen.com
