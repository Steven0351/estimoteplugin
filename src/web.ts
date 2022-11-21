import { WebPlugin } from '@capacitor/core';

import type { sduwbPlugin } from './definitions';

export class sduwbWeb extends WebPlugin implements sduwbPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
