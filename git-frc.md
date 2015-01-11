% Git for FIRST teams
% Matt Soucy (<msoucy@csh.rit.edu>)

# The importance of version control

- Most developers start off not using any
- Tolerable for small projects on one's own
- What happens when you make a mistake?
	- Delete a file
	- Accidentally break compatability with other code
	- Remove comments explaining what something does
	- Introduce a bug amongst your features

---

# Old ways of tracking changes

## Undo/Redo

- This is silly, but usable, for fixing small mistakes that you make
- Only works within one work session
- Close a file, and your change history vanishes

## Zip files/separate folders

- When you're done making changes, or have a version you like, copy the folder
- Store in `.zip` "to save space"...
- This does NOT SCALE WELL. At all. Seriously, it's awful.
- Our team did this until 2008

---

# Older version control systems we used

## Subversion

- Centralizes the code
- One person at a time can "reserve" a file (`checkout`)
- Only the person who has a file checked out can `checkin`
- All users can `svn update` to get the changes from the central server
- Named branches to have alternate build choices
- We did this in 2008 (on Google Code)

## Mercurial

- What if the team can't access the server?
	- This happens ALL THE TIME at competitions
- Multiple people can make changes at once
- Only one `head` can be on the server per branch
	- Users merge them together
- Named branches actually usable
- We used 2009 - 2014 (on Google Code)

---

# Git

- More powerful and widely used than Mercurial
- Doesn't restrict you to using one development pattern
	- But we will
- Branches aren't just common, but *essential*
- We use 2015 - ???? (on [GitHub][])

---

# Using git

- Most commonly, people use the command line for this
- We don't have time to fully teach command line git properly
- Use the Github application (Windows, OSX)
- If you're feeling daring, ask me later
	- According to Mark, you must call me "Oh Captain My Captain" if you exercise this option

---

# Branches

- A branch is just a name for a line of changesets
- All repositories have a branch called `master`
	- This branch is similar to the `default` branch from `hg`
- Depending on your workflow, there may be more

---

# Forks & Pull Requests

- A copy of the repository with some changes
- Owned by someone else
- For the team, each person will maintain their own fork
- The repository you fork from is called "`upstream`"
	- Because changes can "flow" down
- When you want to add your changes to `upstream`, you do it via "pull request"
	- Literally, "I would like you to take my changes"

---

# The team's workflow

- Use the GitHub application
- The [ChopShop repository][] is the "canonical" repository
	- `master` branch: WORKING code that builds
	- `release` branch: Stable code that we trust on the robot
- Your fork contains your work
	- Develop your code in your own copy
	- You're responsible for keeping it up to date
		- Launch the given batch file (`Update.bat`) from the "Git Shell"
		- Make sure the setting for this is `CMD`!
	- You can commit and push whenever it feels appropriate
- When your code is ready to be merged in with the team's code:
	1. Go to your fork on GitHub
	2. Click the big green button with a swirly symbol: ![Pull Request][]
	3. MAKE SURE THE CHANGES BUILD AND LOOK CORRECT
	4. Submit the pull request

---

# Conclusion

- Version control is very good for keeping code organized
- Git lets people work in their own branches
- The workflow gives us control over what code is considered "stable"
<!--- Version control is as easy as *fork*, *spoon*, and *knife*-->

[GitHub]: http://github.com/
[ChopShop repository]: http://github.com/ChopShop-166/frc-2015
[Pull Request]: pull-request.png
