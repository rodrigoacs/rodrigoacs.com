window.onload = getPopularMovies();

function renderMovies(movieTBR) {
    const movie = document.createElement("div")
    movie.classList.add("movie")

    const movieInfos = document.createElement("div")
    movieInfos.classList.add("movie-infos")
    movie.appendChild(movieInfos)

    const moviePoster = document.createElement("div")
    moviePoster.classList.add("movie-poster")
    moviePoster.style.backgroundImage = `url(${movieTBR.image})`
    movieInfos.appendChild(moviePoster)

    const movieTrf = document.createElement("div")
    movieTrf.classList.add("movie-trf")
    movieTrf.innerHTML = `<span>${movieTBR.title} (${movieTBR.year})</span>`
    movieInfos.appendChild(movieTrf)

    const movieRating = document.createElement("div")
    movieRating.classList.add("movie-rating")

    const starIcon = document.createElement("img")
    starIcon.src = "./images/star-icon.png"
    starIcon.style.width = `2.4rem`
    movieRating.appendChild(starIcon)
    movieRating.innerHTML += `<span> ${movieTBR.rating}</span>`

    const movieFavorite = document.createElement("div")
    movieFavorite.classList.add("favorite")
    const favoriteImage = document.createElement("img")
    favoriteImage.classList.add("favorite-button")
    if (movieTBR.isFavorited) {
        favoriteImage.src = "./images/filled-heart-icon.png"
    } else {
        favoriteImage.src = "./images/empty-heart-icon.svg"
    }
    favoriteImage.style.width = `2.4rem`
    const favoriteText = document.createElement("span")
    favoriteText.innerHTML = " Favoritar"
    movieFavorite.appendChild(favoriteImage)
    movieFavorite.appendChild(favoriteText)
    movieTrf.appendChild(movieRating)
    movieTrf.appendChild(movieFavorite)

    const movieDescription = document.createElement("div")
    movieDescription.classList.add("movie-description")
    movieDescription.innerHTML = `${movieTBR.description}`
    movie.appendChild(movieDescription)

    document.querySelector(".movies").appendChild(movie)
}

function fixFormat(movies) {
    let moviesFixed = [];
    moviesFixed = movies.map(movie => {
        return {
            image: `https://image.tmdb.org/t/p/w500/${movie.poster_path}`,
            title: movie.title,
            rating: movie.vote_average,
            year: movie.release_date ? movie.release_date.split("-")[0] : "Não informado",
            description: movie.overview ? movie.overview : "Não informado",
            isFavorited: false
        }
    })
    return moviesFixed;
}

async function getPopularMovies() {
    const url = "https://api.themoviedb.org/3/movie/popular?api_key=04c83eacb1a1a16fb8cfc98c293b0b6d&language=pt-BR"
    const fetchResponse = await fetch(url).then(response => response.json())

    let movies = fixFormat(fetchResponse.results)

    movies.forEach(movie => {
        renderMovies(movie);
    });
    favoriteButton()
}

let favoriteKey = 0;

function favoriteButton() {
    document.querySelectorAll(".favorite-button").forEach(button => {
        button.addEventListener("click", () => {
            const filmTittle = button.parentNode.parentNode.firstChild.innerHTML;
            button.src = button.src.includes("empty") ? "./images/filled-heart-icon.png" : "./images/empty-heart-icon.svg"
            if (button.src.includes("empty")) {
                localStorage.removeItem(`${filmTittle}`)
            }
            favoriteKey = favoriteKey++;
            localStorage.setItem(favoriteKey, `${filmTittle}`)
        });
    })
}

document.getElementById("search-input").addEventListener("keyup", (e) => {
    if (e.keyCode === 13) {
        searchMovie();
    }
})

async function searchMovie() {
    const url = "https://api.themoviedb.org/3/search/movie?api_key=04c83eacb1a1a16fb8cfc98c293b0b6d&language=pt-BR&query=";
    const search = document.getElementById("search-input").value;
    let urlSearch = url + search;
    if (!search) {
        urlSearch = "https://api.themoviedb.org/3/movie/popular?api_key=04c83eacb1a1a16fb8cfc98c293b0b6d&language=pt-BR";
    }

    document.querySelector(".movies").innerHTML = "";

    const fetchResponse = await fetch(urlSearch).then(response => response.json())
    let movies = fixFormat(fetchResponse.results)
    movies.forEach(movie => {
        renderMovies(movie);
    });
    favoriteButton()
}
