function formatRelativeDate(date: Date, now = new Date()): string {
  const diffMs = now.getTime() - date.getTime()
  const diffMinutes = Math.floor(diffMs / (1000 * 60))
  const diffHours = Math.floor(diffMs / (1000 * 60 * 60))
  const diffDays = Math.floor(diffMs / (1000 * 60 * 60 * 24))
  const rtf = new Intl.RelativeTimeFormat(navigator.language || "en-US", { numeric: "auto" })

  if (diffMinutes < 1) {
    return "just now"
  } else if (diffMinutes < 60) {
    return rtf.format(-diffMinutes, "minute")
  } else if (diffHours < 24) {
    return rtf.format(-diffHours, "hour")
  } else if (diffDays < 30) {
    return rtf.format(-diffDays, "day")
  } else if (diffDays < 365) {
    return rtf.format(-Math.floor(diffDays / 30), "month")
  }

  return rtf.format(-Math.floor(diffDays / 365), "year")
}

function updateLatestUpdateDates() {
  const now = new Date()
  document.querySelectorAll<HTMLTimeElement>(".latest-updates time[data-relative-date]").forEach((el) => {
    const date = new Date(el.dateTime)
    if (!Number.isNaN(date.getTime())) {
      el.textContent = formatRelativeDate(date, now)
    }
  })
}

document.addEventListener("nav", updateLatestUpdateDates)

export default ""
