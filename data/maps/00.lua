return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "0.16.2",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 100,
  height = 100,
  tilewidth = 32,
  tileheight = 32,
  nextobjectid = 2,
  properties = {},
  tilesets = {
    {
      name = "collisions",
      firstgid = 1,
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      image = "00.png",
      imagewidth = 512,
      imageheight = 512,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tilecount = 256,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "Tile Layer 1",
      x = 0,
      y = 0,
      width = 100,
      height = 100,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      data = "eJzt1UsKg0AQQEFN7n/nrAMKA0H7Gaqgd35mfKL7tm27+ZpJ03svzqTpvRdnUmUdq/Ro0aNFjxY9WvTgTnq06NHytG/x6n1fi9d7H5w76V97rDQ5aqHHtes9a3LWYrrHFe7qsXJM4R2apkeLHi1X/5OueG566HEXPfiVHi16tOjRokeLHi16tOjRokeLHi16tOjRokeLHi16tOjRogcAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA83we7XwK1"
    },
    {
      type = "objectgroup",
      name = "game_entities",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 1,
          name = "PlayerStart",
          type = "",
          shape = "rectangle",
          x = 352,
          y = 320,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
