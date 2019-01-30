/* Terminal colors (16 first used in escape sequence) */
static const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#2c3e50", /* black   */
  [1] = "#e74c3c", /* red     */
  [2] = "#2ecc71", /* green   */
  [3] = "#f1c40f", /* yellow  */
  [4] = "#3498db", /* blue    */
  [5] = "#9b59b6", /* magenta */
  [6] = "#1abc9c", /* cyan    */
  [7] = "#e0e0e0", /* white   */

  /* 8 bright colors */
  [8]  = "#2c3e50", /* black   */
  [9]  = "#e74c3c", /* red     */
  [10] = "#2ecc71", /* green   */
  [11] = "#f1c40f", /* yellow  */
  [12] = "#3498db", /* blue    */
  [13] = "#9b59b6", /* magenta */
  [14] = "#1abc9c", /* cyan    */
  [15] = "#ecf0f1", /* white   */

  /* special colors */
  [256] = "#2c3e50", /* background */
  [257] = "#8a8986", /* foreground */
};

/*
 * Default colors (colorname index)
 * foreground, background, cursor
 */
static unsigned int defaultfg = 257;
static unsigned int defaultbg = 256;
static unsigned int defaultcs = 257;

/*
 * Colors used, when the specific fg == defaultfg. So in reverse mode this
 * will reverse too. Another logic would only make the simple feature too
 * complex.
 */
static unsigned int defaultitalic = 7;
static unsigned int defaultunderline = 7;
