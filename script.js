const root = document.documentElement;
const img = document.getElementById("change-theme-img");
const theme = document.getElementById("change-theme");
let language = navigator.language || navigator.userLanguage;
const languageOptions = {
  "en-US": {
    icon: "https://img.icons8.com/fluency/48/brazil-circular.png",
    jsonFile: "./en-US.json",
  },
  "pt-BR": {
    icon: "https://img.icons8.com/fluency/48/usa-circular.png",
    jsonFile: "./pt-BR.json",
  },
};

const links = document.querySelectorAll(".link:not(#change-language)");
links.forEach((link) => {
  link.addEventListener("click", (e) => {
    e.preventDefault();
    const pageId = link.getAttribute("href");
    try {
      loadPage(pageId);
    } catch (error) {
      console.error("Failed to load page:", error);
    }
  });
});

function initialize() {
  loadContent(language);
  updateLanguageIcon(language);

  const colorSchemeQuery = window.matchMedia("(prefers-color-scheme: dark)");
  setColorScheme(colorSchemeQuery.matches);

  colorSchemeQuery.addEventListener("change", (event) => {
    setColorScheme(event.matches);
  });
}

function setColorScheme(isDark) {
  isDark ? setDark(root, img) : setLight(root, img);
}

window.addEventListener("load", initialize);

function updateLanguageIcon(language) {
  const iconElement = document.getElementById("change-language");

  if (!iconElement) {
    console.error("changeLanguageIcon element not found");
    return;
  }

  if (!languageOptions[language]) {
    console.error(`Language option for '${language}' not found`);
    return;
  }

  iconElement.innerHTML = `<img width="24" height="24" src="${languageOptions[language].icon}" alt="${language} language icon">`;
}

function updateProjectsTheme() {
  const isDarkMode = root.classList.contains("dark-mode");
  const theme = isDarkMode ? "dark" : "swift";
  const projects = document.querySelectorAll(".project");

  if (projects.length === 0) {
    return;
  }

  projects.forEach((project) => {
    project.src = `https://github-readme-stats.vercel.app/api/pin/?username=rodrigoacs&repo=time-tracker&theme=${theme}&hide_border=true&description_lines_count=1`;
  });
}

function loadPage(pageId) {
  fetch(`${pageId}.html`)
    .then((response) => {
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      return response.text();
    })
    .then((data) => {
      const main = document.querySelector("main");
      if (!main) {
        console.error("Main element not found");
        return;
      }

      main.innerHTML = data;
      document.title = `${pageId} | rodrigoacs.com`;
      highlightLink(pageId);

      main.focus();
    })
    .catch((error) => console.error("Error:", error));
}

function highlightLink(pageId) {
  links.forEach((link) => {
    const isActive = link.classList.contains("active");
    const shouldHaveActive = link.getAttribute("href") === pageId;

    if (isActive && !shouldHaveActive) {
      link.classList.remove("active");
    } else if (!isActive && shouldHaveActive) {
      link.classList.add("active");
    }
  });
}

function loadContent(language) {
  if (!languageOptions[language]) {
    console.error(`Language option for '${language}' not found`);
    return;
  }

  let elements = document.querySelectorAll("[translate]");
  fetch(languageOptions[language].jsonFile)
    .then((response) => {
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      return response.json();
    })
    .then((data) => {
      elements.forEach((element) => {
        let key = element.getAttribute("translate");
        if (data[key]) {
          element.innerHTML = data[key];
        } else {
          console.warn(`Key '${key}' not found in data`);
        }
      });
    })
    .catch((error) => console.error(error));
}

let changeLanguage = document.getElementById("change-language");
if (changeLanguage) {
  changeLanguage.addEventListener("click", () => {
    language = language === "en-US" ? "pt-BR" : "en-US";

    updateLanguageIcon(language);
    loadContent(language);

    activeDownload();
  });
} else {
  console.error("Change language element not found");
}

function activeDownload() {
  if (document.querySelector(".cv-page")) {
    setTimeout(() => {
      let downloadButton = document.getElementById("download");
      downloadButton.addEventListener("click", () => {
        window.print();
      });
    }, 500);
  }
}

const observer = new MutationObserver(() => {
  loadContent(language);
  activeDownload();

  let tech = document.getElementById("tech");
  if (tech) {
    tech.removeEventListener("change", techChangeListener);
    tech.addEventListener("change", techChangeListener);
  }
});

observer.observe(document.body.querySelector(".ajax"), {
  attributes: true,
  childList: true,
  subtree: false,
});

function techChangeListener(event) {
  filterTech(event.target.value);
}

theme.addEventListener("click", changeTheme);

function changeTheme() {
  root.classList.contains("light-mode")
    ? setDark(root, img)
    : setLight(root, img);
}

function setDark(root, img) {
  root.classList.remove("light-mode");
  root.classList.add("dark-mode");
  img.src = "./assets/sun_3d.png";
  updateProjectsTheme();
}

function setLight(root, img) {
  root.classList.remove("dark-mode");
  root.classList.add("light-mode");
  img.src = "./assets/new_moon_3d.png";
  updateProjectsTheme();
}

function filterTech(tech) {
  const projects = document.querySelectorAll(".project");
  projects.forEach((project) => {
    const shouldShow = project.getAttribute("tech") === tech || tech === "all";
    project.classList.toggle("hide", !shouldShow);
  });
}

loadPage("home");
