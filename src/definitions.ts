export interface sduwbPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
