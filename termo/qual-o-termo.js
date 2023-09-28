// Copyright 2021 Fernando Serboncini
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software
// and associated documentation files(the "Software"), to deal in the Software without restriction,
// including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
// and / or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, 
// subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES 
// OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE 
// ;LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

function show() {
    fetch("https://raw.githubusercontent.com/fserb/pt-br/master/dicio")
        .then(response => response.text())
        .then(dictionary => {
            const inputs = document.querySelectorAll("input")
            document.getElementById("result").innerHTML = '';
            dictionary = dictionary.split("\n").filter(word => word.length == 5).map(removeAccent);

            for (let i = 0; i < inputs.length; i++) {
                if (inputs[i].value) {
                    dictionary = dictionary.filter(word => word[i] == inputs[i].value)
                }
            }

            dictionary.forEach(word => {
                document.getElementById("result").innerHTML += `${word.toUpperCase()} `;
            });
        })
}

function info() {
    const info = document.getElementById("info");
    info.style.display = info.style.display == "none" ? "block" : "none";
}

function removeAccent(string) {
    // by https://stackoverflow.com/users/1704264/luan-castro 
    // in https://stackoverflow.com/questions/18236208
    return string.replace(/[áàãâä]/gi, "a")
        .replace(/[éèëê]/gi, "e")
        .replace(/[íìïî]/gi, "i")
        .replace(/[óòöôõ]/gi, "o")
        .replace(/[úùüû]/gi, "u")
        .replace(/[ç]/gi, "c")
        .replace(/[ñ]/gi, "n")
        .replace(/[^a-zA-Z0-9]/g, " ");
}