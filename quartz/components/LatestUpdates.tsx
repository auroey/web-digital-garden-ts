import { QuartzComponent, QuartzComponentConstructor, QuartzComponentProps } from "./types"
import { QuartzPluginData } from "../plugins/vfile"
import { resolveRelative } from "../util/path"
import { FullSlug } from "../util/path"
import { classNames } from "../util/lang"
import { getDate } from "./Date"
import { GlobalConfiguration } from "../cfg"
import style from "./styles/latestUpdates.scss"
import script from "./scripts/latestUpdates.inline"

function formatRelativeDate(date: Date, locale: string, now = new Date()): string {
  const diffMs = now.getTime() - date.getTime()
  const diffMinutes = Math.floor(diffMs / (1000 * 60))
  const diffHours = Math.floor(diffMs / (1000 * 60 * 60))
  const diffDays = Math.floor(diffMs / (1000 * 60 * 60 * 24))
  const rtf = new Intl.RelativeTimeFormat(locale, { numeric: "auto" })

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
  } else {
    return rtf.format(-Math.floor(diffDays / 365), "year")
  }
}

function sortByRecent(a: QuartzPluginData, b: QuartzPluginData, cfg: GlobalConfiguration) {
  const ta = (getDate(cfg, a) ?? new Date(0)).getTime()
  const tb = (getDate(cfg, b) ?? new Date(0)).getTime()
  return tb - ta // Sort by time in descending order (latest first)
}

function sortByInlinks(a: QuartzPluginData, b: QuartzPluginData) {
  const inlinksA = (a.links as string[])?.length ?? 0
  const inlinksB = (b.links as string[])?.length ?? 0
  return inlinksB - inlinksA
}

export default (() => {
  const LatestUpdates: QuartzComponent = ({
    allFiles,
    fileData,
    displayClass,
    cfg,
  }: QuartzComponentProps) => {
    // Filter out current page and noindex pages
    const pages = allFiles
      .filter(p => p.slug !== fileData.slug)
      .filter(p => !(p.frontmatter as any)?.noindex)

    // Latest updates: sort by update time
    const recentPages = pages
      .sort((a, b) => sortByRecent(a, b, cfg))
      .slice(0, 2)

    // Recommended entries: sort by number of references
    const popularPages = pages
      .sort(sortByInlinks)
      .slice(0, 4)

    if (recentPages.length === 0 && popularPages.length === 0) return null

    return (
      <div class={classNames(displayClass, "latest-updates")}>
        {recentPages.length > 0 && (
          <div class="mb-8">
            <h3>Latest Updates</h3>
            <ul class="recent-ul">
              {recentPages.map(p => {
                const date = getDate(cfg, p)
                const dateText = date ? formatRelativeDate(date, cfg.locale) : ""
                const href = resolveRelative(fileData.slug as FullSlug, p.slug as FullSlug)
                const title = (p.frontmatter as any)?.title ?? (p.slug as string)?.split("/").pop() ?? "Untitled"
                return (
                  <li class="recent-li">
                    <div class="section">
                      <div class="desc">
                        <h3>
                          <a href={href} class="internal">
                            {title}
                          </a>
                        </h3>
                      </div>
                      {dateText && date && (
                        <p class="meta">
                          <time datetime={date.toISOString()} data-relative-date>
                            {dateText}
                          </time>
                        </p>
                      )}
                    </div>
                  </li>
                )
              })}
            </ul>
          </div>
        )}

        {popularPages.length > 0 && (
          <div>
            <h3>Recommended</h3>
            <ul class="recent-ul">
              {popularPages.map(p => {
                const inlinksCount = (p.links as string[])?.length ?? 0
                const href = resolveRelative(fileData.slug as FullSlug, p.slug as FullSlug)
                const title = (p.frontmatter as any)?.title ?? (p.slug as string)?.split("/").pop() ?? "Untitled"
                return (
                  <li class="recent-li">
                    <div class="section">
                      <div class="desc">
                        <h3>
                          <a href={href} class="internal">
                            {title}
                          </a>
                        </h3>
                      </div>
                      <p class="meta">
                        ({inlinksCount} references)
                      </p>
                    </div>
                  </li>
                )
              })}
            </ul>
          </div>
        )}
      </div>
    )
  }

  LatestUpdates.css = style
  LatestUpdates.afterDOMLoaded = script
  return LatestUpdates
}) satisfies QuartzComponentConstructor
