## - ¿Qué comando utilizaste en el paso 11? ¿Por qué?
Utilicé el comando `git reset --hard HEAD~1`, que hace que el puntero HEAD y la rama styled vuelvan al commit anterior (HEAD~1). Además, el flag --hard hace que se pierdan los cambios que hubiese en el working copy.

## - ¿Qué comando o comandos utilizaste en el paso 12? ¿Por qué?
Utilicé primero el comando `git reflog` para encontrar el commit anterior, ya que no se puede ver ya en el `git log`. Ahí encuentro el commit anterior y copio su hash para volver a él utilizando el comando `git reset --hard 0b6e806`

## - El merge del paso 13, ¿Causó algún conflicto? ¿Por qué?
Al usar el comando `git merge master` desde la rama styled, no se realiza el merge y la respuesta es "Already up-to-date". Esto se debe a que el commit al que apunta la rama master es *padre* del commit al que apunta la rama styled. Por lo tanto no hay nada que haya cambiado en la rama master que pueda absorber la rama styled.   


## - El merge del paso 19, ¿Causó algún conflicto? ¿Por qué?
Si, causó un  conflicto en el archivo git-nuestro.md, ya que en ambas ramas se han hecho modificaciones diferentes en las mismas líneas del archivo.

## - El merge del paso 21, ¿Causó algún conflicto? ¿Por qué?
Ningún conflicto. La rama styled tiene como nodo padre al commit al que apunta la rama master, así que a la hora del merge en la rama master no se ha modificado ninguna línea del archivo con respecto a la rama styled.

## - ¿Qué comando o comandos utilizaste en el paso 25?
`git log --graph --decorate --pretty=oneline`

## - El merge del paso 26, ¿Podría ser fast forward? ¿Por qué?
SI, podría haber sido fast forward, ya que no hay ninguna modificación de la rama master con respecto a title, es su nodo padre, por lo que el merge se podría hacer simplemente moviendo el cursor de la rama master al commit que apunta el cursor de la rama title.

## - ¿Qué comando o comandos utilizaste en el paso 27?
Utilicé `git reflog` para encontrar el hash del commit anterior al merge, después utilizo `git reset b6f2cf1` para deshacer el merge sin perder los cambios del working copy.

## - ¿Qué comando o comandos utilizaste en el paso 28?
`git checkout -- git-nuestro.md`

## - ¿Qué comando o comandos utilizaste en el paso 29?
Desde la rama master, utilizo `git branch -D title`

## - ¿Qué comando o comandos utilizaste en el paso 30?
Utilicé `git reflog` para encontrar el hash del commit en el que hice el merge, despues con ese hash hago `git reset --hard c4a0ed6`

## - ¿Qué comando o comandos usaste en el paso 32?
Utilicé `git log` para encontrar el hash del commit inicial, después utilicé `git reset --hard c866c592b9ec392ae84af746f3e1d3abf73dcd28
` para volver a él.

## - ¿Qué comando o comandos usaste en el punto 33?
Utilicé `git reflog` para encontrar el hash del commit final (merge de master con title), después utilicé `git reset --hard c4a0ed6
` para volver a él.
