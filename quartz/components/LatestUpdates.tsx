import { QuartzComponent, QuartzComponentConstructor, QuartzComponentProps } from "./types"
import { QuartzPluginData } from "../plugins/vfile"
import { resolveRelative } from "../util/path"
import { FullSlug } from "../util/path"
import { classNames } from "../util/lang"
import { getDate } from "./Date"
import { GlobalConfiguration } from "../cfg"
import style from "./styles/latestUpdates.scss"

function sortByRecent(a: QuartzPluginData, b: QuartzPluginData, cfg: GlobalConfiguration) {
  const ta = (getDate(cfg, a) ?? new Date(0)).getTime()
  const tb = (getDate(cfg, b) ?? new Date(0)).getTime()
  return tb - ta
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
    // 过滤掉当前页面和noindex页面
    const pages = allFiles
      .filter(p => p.slug !== fileData.slug)
      .filter(p => !(p.frontmatter as any)?.noindex)

    // 最新更新：按更新时间排序
    const recentPages = pages
      .sort((a, b) => sortByRecent(a, b, cfg))
      .slice(0, 5)

    // 推荐入口：按被引次数排序
    const popularPages = pages
      .sort(sortByInlinks)
      .slice(0, 5)

    if (recentPages.length === 0 && popularPages.length === 0) return null

    return (
      <div class={classNames(displayClass, "latest-updates")}>
        {recentPages.length > 0 && (
          <div class="mb-8">
            <h3>最新更新</h3>
            <ul class="recent-ul">
              {recentPages.map(p => {
                const date = getDate(cfg, p)
                const dateText = date ? date.toISOString().slice(0, 10) : ""
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
                      {dateText && (
                        <p class="meta">
                          {dateText}
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
            <h3>推荐入口</h3>
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
                        ({inlinksCount} 次引用)
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
  return LatestUpdates
}) satisfies QuartzComponentConstructor
