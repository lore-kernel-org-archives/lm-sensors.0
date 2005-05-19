From: mauricetanderson@yahoo.com (Maurice Anderson)
Date: Thu, 19 May 2005 06:25:39 +0000
Subject: i2c v. SMbus
Message-Id: <20050222023851.61045.qmail@web40422.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello,

I came across your name while researching the i2c and
SMbus architecture.  If you have a few moments to
spare of your precious time I would really appreciate
it.  Could you clear up a few questions for me?  Here
they are:

  1.)  I notice that most of the i2c programs
       I run into connect to an external eeprom
       through the laptop serial or parallel port.
      =20
       But what if I want to read an Eeprom on my =20
       own laptop.  That is, the one connected to
       the internal SMbus, is this possible?

  2.)  Do I have to do the i2c start, stop, etc?

  3.)  What I/O address do I use?  With
       the aforementioned i2c programs they use
       the serial port with address 0xF8.  So
       what would be the address for the Eeprom
       on the SMbus?

  4.)  Is the I/O address of the SMbus and Eeprom
       itself the same on both Linux and Windows
       based systems?

  5.)  What are the I/O address of both on Windows?

  6.)  What if I wanted to write a DOS based program?

  7.)  Any simple code examples you could share?

Thanks for your help,

-M-











=20


	=09
__________________________________=20
Do you Yahoo!?=20
All your favorites on one personal page =96 Try My Yahoo!
http://my.yahoo.com=20
