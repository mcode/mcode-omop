module.exports = {
  'env': {
    'commonjs': true,
    'es6': true,
    'node': true
  },
  overrides: [
    {
      files: ['*.js'],
      'extends': 'eslint:recommended',
      'globals': {
        'Atomics': 'readonly',
        'SharedArrayBuffer': 'readonly'
      },
      'parserOptions': {
        'ecmaVersion': 2018
      },
      'rules': {
        'indent': [
          'error',
          2
        ],
        'linebreak-style': [
          'error',
          'unix'
        ],
        'no-var': [
          'error'
        ],
        'quotes': [
          'error',
          'single'
        ],
        'semi': [
          'error',
          'always'
        ]
      }
    },
    {
      files: ['*.ts'],
      extends: [
        'eslint:recommended',
        'plugin:@typescript-eslint/recommended',
        'plugin:@typescript-eslint/recommended-requiring-type-checking'
      ],
      parser: '@typescript-eslint/parser',
      parserOptions: {
        ecmaVersion: 2020,
        sourceType: 'module',
        project: 'tsconfig.lint.json'
      },
      plugins: [
        '@typescript-eslint'
      ]
    }
  ]
};
