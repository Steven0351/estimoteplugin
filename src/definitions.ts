export interface sduwbPlugin {
  createManager(): Promise< any>;
  startScanning(handle: string) : Promise< any>;
}
