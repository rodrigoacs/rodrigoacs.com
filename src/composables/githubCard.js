export function generateGithubStatsUrl(repository, theme) {
  const themeSettings = {
    light: {
      title_color: '000000',
      icon_color: '8338ec',
      text_color: '000000',
      bg_color: 'f0f0f0',
    },

    dark: {
      title_color: 'ffffff',
      icon_color: '9381ff',
      text_color: 'd4d4d4',
      bg_color: '161616',
    },
  }

  const { title_color, icon_color, text_color, bg_color } = themeSettings[theme]

  return `https://github-readme-stats.vercel.app/api/pin?title_color=${title_color}&icon_color=${icon_color}&text_color=${text_color}&bg_color=${bg_color}&hide_border=true&username=rodrigoacs&locale=en&show_icons=false&repo=${repository}&description_lines_count=1`
}
