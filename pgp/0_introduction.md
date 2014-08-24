# PGP Key-Signing Party

## Cryptography and human recognition

- Presented by Matthew Soucy <msoucy@csh.rit.edu>
- Inspiration, guidance, and some slides by Ralph Bean

4096R/B2370F0C 2013-04-20  
33A9 6558 38DE 94B9 B85B  A0DC 7996 734F B237 0F0C

Slides available at http://msoucy.me/seminars/pgp

![Creative Commons Share-Alike](http://i.creativecommons.org/l/by-sa/3.0/88x31.png)

---

# What is GPG (wikipedia quote time)

*Pretty Good Privacy (PGP)* is a data encryption and decryption program that provides cryptographic privacy and authentication for data communication.
PGP is often used for signing, encrypting, and decrypting texts, e-mails, files, directories, and even whole disk partitions.

GNU Privacy Guard (GnuPG or GPG) is a GPL Licensed alternative to the PGP suite of cryptographic software.

X.509 is an ITU-T standard for a public key infrastructure (PKI) and a Privilege Management Infrastructure (PMI).
It specifies, amongst other things, standard formats for public key certificates, certificate revocation lists,
attribute certificates, and a certification path validation algorithm.
It assumes a strict hierarchical system of certificate authorities (CAs) for issuing the certificates.

---

# Why use GPG?

- Signing communications
  - Your friend receives a fraudulent email from your address, asking them to give another person access to a shared project with proprietary information.
    If you usually sign with GPG, and this email is not signed, then your friend is more likely to notice that something is wrong.
- Encrypting communications
  - You are a sysadmin and you need to email someone a password.
    Do it in plaintext? **NO**.
	Encrypt the message using the *public key* of the *recipient*.
- Signing Data
  - Uploading tarballs of project releases, you sign with a personal key first to show others that this release is legitimate.
    Some projects use a project-specific key shared by all release managers.
- Encrypting Data
  - Sometimes you need to share a dump of some proprietary information with another person, but it should not be put online.
    Encrypt with the *public key* of the *recepient* so that only they can read the file.
