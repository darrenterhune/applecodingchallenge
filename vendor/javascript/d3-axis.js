// d3-axis@3.0.0 downloaded from https://ga.jspm.io/npm:d3-axis@3.0.0/src/index.js

function identity(t){return t}var t=1,n=2,r=3,i=4,e=1e-6;function translateX(t){return"translate("+t+",0)"}function translateY(t){return"translate(0,"+t+")"}function number(t){return n=>+t(n)}function center(t,n){n=Math.max(0,t.bandwidth()-2*n)/2;t.round()&&(n=Math.round(n));return r=>+t(r)+n}function entering(){return!this.__axis}function axis(a,s){var o=[],u=null,c=null,l=6,x=6,f=3,d="undefined"!==typeof window&&window.devicePixelRatio>1?0:.5,m=a===t||a===i?-1:1,h=a===i||a===n?"x":"y",g=a===t||a===r?translateX:translateY;function axis(p){var k=null==u?s.ticks?s.ticks.apply(s,o):s.domain():u,y=null==c?s.tickFormat?s.tickFormat.apply(s,o):identity:c,A=Math.max(l,0)+f,M=s.range(),v=+M[0]+d,w=+M[M.length-1]+d,_=(s.bandwidth?center:number)(s.copy(),d),b=p.selection?p.selection():p,F=b.selectAll(".domain").data([null]),V=b.selectAll(".tick").data(k,s).order(),z=V.exit(),H=V.enter().append("g").attr("class","tick"),C=V.select("line"),R=V.select("text");F=F.merge(F.enter().insert("path",".tick").attr("class","domain").attr("stroke","currentColor"));V=V.merge(H);C=C.merge(H.append("line").attr("stroke","currentColor").attr(h+"2",m*l));R=R.merge(H.append("text").attr("fill","currentColor").attr(h,m*A).attr("dy",a===t?"0em":a===r?"0.71em":"0.32em"));if(p!==b){F=F.transition(p);V=V.transition(p);C=C.transition(p);R=R.transition(p);z=z.transition(p).attr("opacity",e).attr("transform",(function(t){return isFinite(t=_(t))?g(t+d):this.getAttribute("transform")}));H.attr("opacity",e).attr("transform",(function(t){var n=this.parentNode.__axis;return g((n&&isFinite(n=n(t))?n:_(t))+d)}))}z.remove();F.attr("d",a===i||a===n?x?"M"+m*x+","+v+"H"+d+"V"+w+"H"+m*x:"M"+d+","+v+"V"+w:x?"M"+v+","+m*x+"V"+d+"H"+w+"V"+m*x:"M"+v+","+d+"H"+w);V.attr("opacity",1).attr("transform",(function(t){return g(_(t)+d)}));C.attr(h+"2",m*l);R.attr(h,m*A).text(y);b.filter(entering).attr("fill","none").attr("font-size",10).attr("font-family","sans-serif").attr("text-anchor",a===n?"start":a===i?"end":"middle");b.each((function(){this.__axis=_}))}axis.scale=function(t){return arguments.length?(s=t,axis):s};axis.ticks=function(){return o=Array.from(arguments),axis};axis.tickArguments=function(t){return arguments.length?(o=null==t?[]:Array.from(t),axis):o.slice()};axis.tickValues=function(t){return arguments.length?(u=null==t?null:Array.from(t),axis):u&&u.slice()};axis.tickFormat=function(t){return arguments.length?(c=t,axis):c};axis.tickSize=function(t){return arguments.length?(l=x=+t,axis):l};axis.tickSizeInner=function(t){return arguments.length?(l=+t,axis):l};axis.tickSizeOuter=function(t){return arguments.length?(x=+t,axis):x};axis.tickPadding=function(t){return arguments.length?(f=+t,axis):f};axis.offset=function(t){return arguments.length?(d=+t,axis):d};return axis}function axisTop(n){return axis(t,n)}function axisRight(t){return axis(n,t)}function axisBottom(t){return axis(r,t)}function axisLeft(t){return axis(i,t)}export{axisBottom,axisLeft,axisRight,axisTop};

