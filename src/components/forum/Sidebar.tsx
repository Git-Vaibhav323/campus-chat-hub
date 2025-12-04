import { TrendingUp, AlertCircle, Flame } from "lucide-react";
import { TrendingPost, Category } from "@/types/post";
import { categories, guidelines } from "@/data/forumData";
import { cn } from "@/lib/utils";

interface SidebarProps {
  trending: TrendingPost[];
}

const categoryColors: Record<Category, string> = {
  all: "bg-primary/20 text-primary",
  news: "bg-blue-500/20 text-blue-400",
  "campus-updates": "bg-orange-500/20 text-orange-400",
  academics: "bg-emerald-500/20 text-emerald-400",
  events: "bg-pink-500/20 text-pink-400",
  Gossips: "bg-purple-500/20 text-purple-400",
  clubs: "bg-cyan-500/20 text-cyan-400",
  placements: "bg-amber-500/20 text-amber-400",
};

const Sidebar = ({ trending }: SidebarProps) => {
  return (
    <aside className="w-80 shrink-0 space-y-6">
      {/* Trending */}
      <div className="bg-card border border-border rounded-xl p-5 shadow-[0_0_8px_rgba(255,0,0,0.15)]">
        <div className="flex items-center gap-2 mb-5">
          <TrendingUp className="w-4 h-4 text-primary" />
          <span className="font-medium">Trending Now</span>
        </div>
        <div className="space-y-4">
          {trending.map((post, index) => {
            const cat = categories.find((c) => c.id === post.category);
            return (
              <div
                key={post.id}
                className="flex items-start gap-3 group cursor-pointer"
              >
                <div className="flex items-center gap-1.5 shrink-0">
                  <span className="text-lg font-bold text-muted-foreground w-5">
                    {index + 1}
                  </span>
                  <Flame className="w-3.5 h-3.5 text-primary" />
                </div>
                <div className="flex-1 min-w-0">
                  <p className="text-sm text-foreground group-hover:text-primary transition-colors line-clamp-2">
                    {post.title}
                  </p>
                  <div className="flex items-center gap-2 mt-1.5">
                    <span
                      className={cn(
                        "px-2 py-0.5 rounded text-[10px] font-medium",
                        categoryColors[post.category]
                      )}
                    >
                      {cat?.label}
                    </span>
                    <span className="text-[10px] text-primary">+{post.score}</span>
                  </div>
                </div>
              </div>
            );
          })}
        </div>
      </div>

      {/* Guidelines */}
      <div className="bg-card border border-border rounded-xl p-5 shadow-[0_0_8px_rgba(255,0,0,0.15)] bg-secondary/30 flex flex-col">
        <div className="flex items-center gap-2 mb-5 shrink-0">
          <AlertCircle className="w-4 h-4 text-destructive" />
          <span className="font-medium">Guidelines</span>
        </div>
        <ul className="space-y-3 overflow-y-auto max-h-64 pr-2 scrollbar-thin">
          {guidelines.map((rule, i) => (
            <li key={i} className="flex items-start gap-3 text-sm text-muted-foreground">
              <span className="text-destructive mt-0.5 text-lg leading-none shrink-0">•</span>
              <span className="leading-relaxed">{rule}</span>
            </li>
          ))}
        </ul>
      </div>
    </aside>
  );
};

export default Sidebar;
