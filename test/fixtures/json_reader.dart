const String pokemonDetailJsonString = '''
{
  "id": 1,
  "name": "bulbasaur",
  "height": 7,
  "weight": 69,
  "types": [
    {
      "type": {
        "name": "grass"
      }
    },
    {
      "type": {
        "name": "poison"
      }
    }
  ],
  "abilities": [
    {
      "ability": {
        "name": "overgrow"
      }
    },
    {
      "ability": {
        "name": "chlorophyll"
      }
    }
  ],
  "sprites": {
    "front_default": "https://example.com/sprite.png",
    "other": {
      "official-artwork": {
        "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png"
      }
    }
  },
  "stats": [
    {
      "base_stat": 45,
      "stat": {
        "name": "hp"
      }
    },
    {
      "base_stat": 49,
      "stat": {
        "name": "attack"
      }
    },
    {
      "base_stat": 49,
      "stat": {
        "name": "defense"
      }
    },
    {
      "base_stat": 65,
      "stat": {
        "name": "special-attack"
      }
    },
    {
      "base_stat": 65,
      "stat": {
        "name": "special-defense"
      }
    },
    {
      "base_stat": 45,
      "stat": {
        "name": "speed"
      }
    }
  ]
}
''';

const String pokemonListJsonString = '''
{
  "count": 1302,
  "next": "https://pokeapi.co/api/v2/pokemon?offset=20&limit=20",
  "previous": null,
  "results": [
    {
      "name": "bulbasaur",
      "url": "https://pokeapi.co/api/v2/pokemon/1/"
    },
    {
      "name": "ivysaur",
      "url": "https://pokeapi.co/api/v2/pokemon/2/"
    }
  ]
}
''';
