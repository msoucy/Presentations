# Quick recap

- Signing a key is a sign of trust of **IDENTITY**, not **CHARACTER**
- Keys can be used to sign or encrypt data and communications
- By being part of the Web of Trust, you help verify identities
- Key signing is a great way to meet people at conferences
- NEVER sign a key belonging to someone you have not met face-to-face
- NEVER sign a key if you have not verified that person's identity.

---

# Key Signing Parties

A key signing party is a way for a bunch of people to sign each others' keys.
This helps build their web of trust.

Everyone here should have a key generated at this point.

---

# Identification

To verify someone's identity, one should
Peoples' preferred forms of ID may differ, but typically the following are used:

- Passport (Any variety)
- Driver's license
- School ID (Least-preferred, least-secure)

---

# Steps in a party

- The other person verifies that the key on the list is their key.
- You receive their key from the server
- You verify their identification
- You sign the key using your key
- You email the key to the email address listed in the key
- They send the key back to the keyserver

---

# The party, on a computer

The typical flow for these commands looks like this:

	# Using my key as an example:
	# Download their key
	gpg --keyserver hkp://subkeys.pgp.net --recv-keys B2370F0C
	# Sign the key
	gpg --sign-key B2370F0C
	# Create an updated key that includes your signature
	# Email the resulting file to the email address
	gpg --armor --output B2370F0C.signed-by.YOUR_KEY.asc --export B2370F0C
	# Import the key that you received
	gpg --import YOUR_KEY.signed-by.B2370F0C.asc
	# Verify all signatures
	gpg --list-sigs YOUR_KEY
	# Send your newly-signed key to the server
	gpg --send-keys YOUR_KEY

