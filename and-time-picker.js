(function(){var a,b,c,d,e,f,g,h,i=[].indexOf||function(a){for(var b=0,c=this.length;c>b;b++)if(b in this&&this[b]===a)return b;return-1},j=[].slice;d='header [data-and-time-picker="hours"]',g='header [data-and-time-picker="minutes"]',c='section [data-and-time-picker="hours"]',f='section [data-and-time-picker="minutes"]',b=""+c+" a",e=""+f+" a",h=function(a){return 10>a?"0"+a:a},a=function(){function a(a,j){var k,l,m,n,o,p,q=this;null==j&&(j={}),o={buttonText:"Accept",hour:0,minute:0};for(m in j)p=j[m],o[m]=p;this.callbacks={},this.hourValue=o.hour,this.minuteValue=o.minute,this.element="string"==typeof a?document.querySelector(a):a,this.element.classList.add("and-time-picker"),k=function(){var a,b;for(b=[],l=a=1;24>=a;l=++a)b.push('<a data-hour="'+(24===l?0:l)+'">'+(24===l?"00":l)+"</a>");return b}().join(""),n=function(){var a,b;for(b=[],l=a=0;11>=a;l=++a)l*=5,b.push('<a data-minute="'+l+'">'+h(l)+"</a>");return b}().join(""),this.element.innerHTML='<header>\n    <a data-and-time-picker="hours">'+h(o.hour)+'</a>:<a data-and-time-picker="minutes">'+h(o.minute)+'</a>\n</header>\n<section>\n    <span></span>\n    <hr />\n    <div data-and-time-picker="hours">\n        '+k+'\n    </div>\n    <div data-and-time-picker="minutes">\n        '+n+"\n    </div>\n</section>\n<button>"+o.buttonText+"</button>",this.hr=this.element.querySelector("hr"),this.element.addEventListener("click",function(a){var c,f,h,j;return c=a.target,i.call(q.element.querySelectorAll(d),c)>=0&&q.goToHourSelection(),f=a.target,i.call(q.element.querySelectorAll(g),f)>=0&&q.goToMinuteSelection(),h=a.target,i.call(q.element.querySelectorAll(b),h)>=0&&(q.setHour(a.target.attributes["data-hour"].value),q.goToMinuteSelection()),j=a.target,i.call(q.element.querySelectorAll(e),j)>=0&&(q.setMinute(a.target.attributes["data-minute"].value),q.accept()),"BUTTON"===a.target.nodeName?q.accept():void 0}),this.element.addEventListener("mouseover",function(a){var c,d;return c=a.target,i.call(q.element.querySelectorAll(b),c)>=0&&q.selectHour(a.target.attributes["data-hour"].value),d=a.target,i.call(q.element.querySelectorAll(e),d)>=0?q.selectMinute(a.target.attributes["data-minute"].value):void 0}),this.element.querySelector(c).addEventListener("mouseleave",function(){return q.selectHour(q.hourValue)}),this.element.querySelector(f).addEventListener("mouseleave",function(){return q.selectMinute(q.minuteValue)}),this.goToHourSelection()}return a.prototype.getHour=function(){return this.hourValue},a.prototype.getMinute=function(){return this.minuteValue},a.prototype.selectHour=function(a){var c;return null!=(c=this.element.querySelector(""+b+".active"))&&c.classList.remove("active"),this.element.querySelector(""+b+'[data-hour="'+a+'"]').classList.add("active"),this.hr.style.transform="rotate("+(30*a-180)+"deg)",this.hr.className=a>=1&&12>=a?"short":"long",this},a.prototype.selectMinute=function(a){var b;return null!=(b=this.element.querySelector(""+e+".active"))&&b.classList.remove("active"),this.element.querySelector(""+e+'[data-minute="'+a+'"]').classList.add("active"),this.hr.style.transform="rotate("+(30*(a/5)-180)+"deg)",this.hr.className="middle",this},a.prototype.setHour=function(a){return this.hourValue=a,this.element.querySelector(d).innerHTML=h(this.hourValue),this.selectHour(this.hourValue),this.trigger("hour",this.hourValue),this},a.prototype.setMinute=function(a){return this.minuteValue=a,this.element.querySelector(g).innerHTML=h(this.minuteValue),this.selectMinute(this.minuteValue),this.trigger("minute",this.minuteValue),this},a.prototype.goToHourSelection=function(){return this.selectHour(this.hourValue),this.element.classList.remove("and-time-picker-minute-selection"),this.element.classList.add("and-time-picker-hour-selection"),this},a.prototype.goToMinuteSelection=function(){return this.selectMinute(this.minuteValue),this.element.classList.remove("and-time-picker-hour-selection"),this.element.classList.add("and-time-picker-minute-selection"),this},a.prototype.accept=function(){return this.trigger("accept",""+h(this.hourValue)+":"+h(this.minuteValue)),this},a.prototype.trigger=function(){var a,b,c,d,e,f,g;if(c=arguments[0],a=2<=arguments.length?j.call(arguments,1):[],null!=(f=this.callbacks[c])?f.length:void 0)for(g=this.callbacks[c],d=0,e=g.length;e>d;d++)b=g[d],b.apply(this,a);return this},a.prototype.bind=function(a,b){return this.callbacks[a]||(this.callbacks[a]=[]),this.callbacks[a].push(b),this},a.prototype.unbind=function(a,b){var c;return this.callbacks[a]=b?function(){var d,e,f,g;if(c!==b){for(f=this.callbacks[a],g=[],d=0,e=f.length;e>d;d++)c=f[d],g.push(c);return g}}.call(this):[],this},a}(),window.AndTimePicker=a}).call(this);