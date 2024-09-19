import { registerPlugin } from '@capacitor/core';

import type { BrotherPrinterPlugin } from './definitions';

const BrotherPrinter = registerPlugin<BrotherPrinterPlugin>('BrotherPrinter', {
  web: () => import('./web').then(m => new m.BrotherPrinterWeb()),
});

export * from './definitions';
export { BrotherPrinter };