const I=document.getElementById("previousDate"),S=document.getElementById("nextDate"),v=document.getElementById("currentDate"),x=document.getElementById("add");document.getElementById("calculate");const m=document.getElementById("result");let c=new Date,p=0;v.innerText=h(c);I.addEventListener("click",()=>T(-1));S.addEventListener("click",()=>T(1));x.addEventListener("click",k);setInterval($,500);function T(t){c.setDate(c.getDate()+t),v.innerText=h(c)}function h(t){return`${t.getDate()}/${t.getMonth()+1}/${t.getFullYear()}`}function B(t,e){const n=new Date;return t=g(n,t),e=g(n,e),(e-t)/6e4}function g(t,e){const[n,o]=e.split(":");return new Date(t.getFullYear(),t.getMonth(),t.getDate(),n,o).getTime()}function $(){const t=document.querySelectorAll(".interval");let e=0;for(const a of t){const d=a.children[0].children[0].value,l=a.children[0].children[1].value,D=a.children[0].children[2];if(d&&l){const s=B(d,l);e+=s;const u=f(s),y=u[0].toString().padStart(2,"0"),E=u[1].toString().padStart(2,"0");D.value=`${y}:${E}`}}if(e===p)return;p=e;const n=f(e);if(e===0)return m.innerText="Nenhuma atividade adicionada";const o=n[0].toString().padStart(2,"0"),i=n[1].toString().padStart(2,"0");m.innerText=`${o}:${i}`}function f(t){const e=parseInt(t/60),n=t-e*60;return[e,n]}function k(){const t=document.createElement("div"),e=document.createElement("div");t.classList.add("interval");const n=r("time"),o=r("time"),i=r("text"),a=r("text",!0);e.appendChild(n),e.appendChild(o),e.appendChild(a),t.appendChild(e),t.appendChild(i),document.body.appendChild(t)}function r(t,e=!1){const n=document.createElement("input");return n.type=t,e&&(n.readOnly=!0),n}