import { registerPlugin } from '@capacitor/core';

import type { sduwbPlugin } from './definitions';

const sduwb = registerPlugin<sduwbPlugin>('sduwb', {
//  web: () => import('./web').then(m => new m.sduwbWeb()),
});

export * from './definitions';
export { sduwb};
