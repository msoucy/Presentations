# Visualizing the Web of Trust

	!bash
	gpg --list-sigs --keyring ~/.gnupg/pubring.gpg | \
	    sig2dot > ~/.gnupg/pubring.dot
	neato -Tps ~/.gnupg/pubring.dot > ~/.gnupg/pubring.ps
	convert ~/.gnupg/pubring.ps ~/.gnupg/pubring.gif
	eog ~/.gnupg/pubring.gif

![Matt Soucy Web of Trust](soucy_small.gif)

---

# What signing another key means

It means that you trust that the key belongs to the person that it says it does.

It does *not* mean that you trust that person.

If you receive an executable from somebody you don't know, but I've signed their key,
it does *not* mean that I trust that they would not do anything malicious.
It merely means "I trust that this person is actually the person who sent this to you".

---

# Creating your key

Before you can sign any keys, you need a key of your own to sign *with*.

You can do this with:

    gpg --gen-key

Your key is stored in ~/.gnupg/
To check your key, run the following:

    gpg --fingerprint 'your@email.here'

Your **fingerprint** is a short identifier that represents your key.
My output:

	pub   096R/B2370F0C 2013-04-20
          Key fingerprint = 33A9 6558 38DE 94B9 B85B  A0DC 7996 734F B237 0F0C
    uid                  Matthew Soucy <msoucy@csh.rit.edu>
    uid                  Matthew Soucy <mas5997@rit.edu>
    sub   4096R/2FD2F40B 2013-04-20

---

# Sending your key

In order for other people to verify that a key belongs to you, and to sign it, you send it to a keyserver.

This is your ***public*** key. Your private key should, as you might expect, stay private.

	gpg --keyserver hkp://subkeys.pgp.net --send-key KEYNAME
	# So for my example:
	gpg --keyserver hkp://subkeys.pgp.net --send-key B2370F0C

 The keyservers all synchronize, so in practice it doesn't matter which server you use.
 However, since many people here just made their keys now, it's better to all use the same server
 so that there are no delays or timing problems.

 You're able to add email addresses to your key later on.
