import fs from 'fs/promises';

async function main() {
  const code = `
      import {BaseModule} from 'lisk-sdk';
      
      export class MyModule extends BaseModule {
      };
  `;

  // make sure fresh userspace dir is used
  await fs.rm('userspace/code', { recursive: true, force: true });
  await fs.mkdir('userspace/code');

  await fs.writeFile('userspace/code/main.ts', code);

  // @ts-ignore
  const mainModule = await import('../userspace/code/main');
  console.debug('MyModule', mainModule.MyModule);
}
main();
