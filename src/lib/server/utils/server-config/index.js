const Configstore = require('configstore');
const Promise = require('promise');
const inquirer = require('inquirer');
const pkg = require('../../../../package.json');
const prompts = require('./setup-prompts');

class ServerConfig {

  static DEFAULTS = {
    'isFirstRun': true,
    'serverPort': '3000'
  }

  constructor(defaults = this.constructor.DEFAULTS) {
    this.db = new Configstore(pkg.name, defaults);
  }

  prompt() {
    return new Promise((resolve, reject) => {
      console.log('> Preparing initial setup\n');

      inquirer.prompt(prompts, answers => {
        Object.keys(answers).map(key => {
          return this.db.set(key, answers[key]);
        });

        this.db.set('isFirstRun', false);

        resolve('\n> Setup finished!\n');
      });
    });
  }
}

module.exports = new ServerConfig();