From: achim <achim@ag-web.biz>
Date: Sun, 04 May 2008 15:27:22 +0000
Subject: Re: [lm-sensors] sensors-detect killed my CPU
Message-Id: <1209914842.3471.12.camel@debian-9850.ag-home.muc>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-TRDTM04jk+gcldOMwlHn"
List-Id: <lm-sensors.vger.kernel.org>
References: <481B851A.10800@ag-web.biz>
In-Reply-To: <481B851A.10800@ag-web.biz>
To: lm-sensors@vger.kernel.org


--=-TRDTM04jk+gcldOMwlHn
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

> The odd thing is the Sapphire board uses the same clock chip as the M3A
> but does not show that chip at 0x69.

Now with the 9600BE in the sapphire board there are additional chips=20

X2 5000BE
---------------------------------------------------
    0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- --=20
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- 2e --=20
30: -- -- -- -- -- -- -- -- 38 -- -- -- -- -- -- --=20
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- 4e --=20
50: -- -- 52 53 -- -- -- 57 -- -- -- -- -- -- -- --=20
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- 6e --=20
70: 70 -- -- -- -- -- -- --                        =20
---------------------------------------------------

9600BE
=EF=BB=BF---------------------------------------------------
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- --=20
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- 2e --=20
30: -- -- -- -- -- -- -- -- 38 -- -- -- -- -- -- --=20
40: -- -- -- -- -- -- -- 47 -- -- -- -- 4c -- 4e --=20
50: -- -- 52 53 -- -- -- 57 -- -- -- -- -- -- -- --=20
60: -- -- -- -- -- -- -- -- -- 69 -- -- -- -- 6e --=20
70: 70 -- -- -- -- -- -- --                     =20
=EF=BB=BF---------------------------------------------------

Now the clock chips shows up at 0x69 maybe a second run with the X2
would also have shown it.

I spotted one thing. The output of 0x38 is identical on the M3A and the
Sapphire board and slightly different on the GBT board.
M3A and Sapphire use the same clock chip =EF=BB=BF9LPRS477BKL the GBT
an =EF=BB=BF9LPRS477CKL. Seems this 0x38 address also point to the cloch
generator.

I tried all types of bios modifications but none showed up at the dumps
of 0x4e and 0x6e.

Trying to dump 0x47 results in XX till i reboot.

For the record I attached the dumps of 0x38 0x57 0x4c 0x69 0x6e and
0x70=20

If I run sensors-detect and pass 0x2e,0x6e,0x47 as excludes, will it
pass?

With the current patch applied the scanning will be completely skipped,
so i can't test the patch atm.

>=20
> >=20
> > > > none of those adddresses can be dumped. I Tried each one after a =
cold
> > > > start, because as you expected this was required on the sapphire =
board
> > > > to get the dump work again.
> >=20
> > Hmmm, that's strange. 0x50 and 0x51 are your memory module SPD EEPROM=
s,
> > they should be dumpable. For 0x69 you should use the "s" mode of
> > i2cdump.
> >=20
> I must use nolapci and irqpoll to boot the 2.6.24 kernel on that
> machine, does this have an impact?
> > > >=20
> > > > I also have an Gigabyte 780G board and an Asus M3A board (770 chi=
pset)
> > > > here.
> > > > =EF=BB=BF
> > No idea what is the chip at 0x38. At 0x69 it's usually clock chips.
> Maybe it is the voltage regulator chip, on the M3A it's this one
>=20
> ISL6559
> http://www.st.com/stonline/products/literature/ds/13605.pdf
>=20
> on the GBt board it's a ISL6323
> http://www.intersil.com/data/fn/fn9278.pdf
>=20
> The sapphire board has digital PWM and no voltage regulator chip.
>=20
> The DFI Lanparty NF4 has an voltage regulator chip at the right bottom
> http://www.techpowerup.com/reviews/DFI/LPNF4Expert/images/board.jpg
>=20
> http://www.techpowerup.com/reviews/DFI/LPNF4Expert/images/cpuarea.jpg
> ISL6559CB
>=20
> All those voltage regulator chips seem to have no smbus interface so th=
e
> chip at 0x2e and 0x4e must be something different.
>=20
> At 0x6e i'd expect the clock generator. I'll switch back to the sapphir=
e
> board now and will do some ref HT modifications there. Is there a simpl=
e
> way to skip the reading at 0x9e?
>=20
>=20
>=20
> I found the part number of chip number four. :)
> It's an ICS9DB403DGLF
>=20
> http://www.idt.com/?genID=3D9DB403
>=20
> I just skimmed over the specs, that chip is related to the pcie and has
> an smbus interface.
>=20
> How did you find out the address of the 690G clock chips by looking at
> the specs?
>=20
>=20
> >=20
> > Note that sensors-detect (at least recent versions thereof) doesn't
> > probe address 0x38 nor 0x69, as there are no known hardware monitorin=
g
> > chips using these addresses.
> >=20
>=20
>=20
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

--=-TRDTM04jk+gcldOMwlHn
Content-Disposition: attachment; filename=i2cdump-0x4c.txt
Content-Type: text/plain; name=i2cdump-0x4c.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 14 00 00 08 00 00 46 00 00 00 00 00 00 00 00    .?..?..F........
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
30: 45 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    E...............
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................

--=-TRDTM04jk+gcldOMwlHn
Content-Disposition: attachment; filename=i2cdump-0x4e.txt
Content-Type: text/plain; name=i2cdump-0x4e.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 02 00 05 05 3f 00 00 00 00 00 00 00 00 00 00 00    ?.???...........
10: 00 00 ff 0f 00 00 00 00 00 00 00 00 00 00 00 00    ...?............
20: 00 00 00 00 00 00 00 00 83 12 12 28 00 00 00 00    ........???(....
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................

--=-TRDTM04jk+gcldOMwlHn
Content-Disposition: attachment; filename=i2cdump-0x38.txt
Content-Type: text/plain; name=i2cdump-0x38.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 01 00 00 00 00 40 2c 14 00 b4 08 00 7c 04 00 00    ?....@,?.??.|?..
10: 01 00 00 00 00 40 2c 14 00 b4 08 00 7c 04 00 00    ?....@,?.??.|?..
20: 01 00 00 00 00 40 2c 14 00 b4 08 00 7c 04 00 00    ?....@,?.??.|?..
30: 01 00 00 00 00 40 2c 14 00 b4 08 00 7c 04 00 00    ?....@,?.??.|?..
40: 01 00 00 00 00 40 2c 14 00 b4 08 00 7c 04 00 00    ?....@,?.??.|?..
50: 01 00 00 00 00 40 2c 14 00 b4 08 00 7c 04 00 00    ?....@,?.??.|?..
60: 01 00 00 00 00 40 2c 14 00 b4 08 00 7c 04 00 00    ?....@,?.??.|?..
70: 01 00 00 00 00 40 2c 14 00 b4 08 00 7c 04 00 00    ?....@,?.??.|?..
80: 01 00 00 00 00 40 2c 14 00 b4 08 00 7c 04 00 00    ?....@,?.??.|?..
90: 01 00 00 00 00 40 2c 14 00 b4 08 00 7c 04 00 00    ?....@,?.??.|?..
a0: 01 00 00 00 00 40 2c 14 00 b4 08 00 7c 04 00 00    ?....@,?.??.|?..
b0: 01 00 00 00 00 40 2c 14 00 b4 08 00 7c 04 00 00    ?....@,?.??.|?..
c0: 01 00 00 00 00 40 2c 14 00 b4 08 00 7c 04 00 00    ?....@,?.??.|?..
d0: 01 00 00 00 00 40 2c 14 00 b4 08 00 7c 04 00 00    ?....@,?.??.|?..
e0: 01 00 00 00 00 40 2c 14 00 b4 08 00 7c 04 00 00    ?....@,?.??.|?..
f0: 01 00 00 00 00 40 2c 14 00 b4 08 00 7c 04 00 00    ?....@,?.??.|?..

--=-TRDTM04jk+gcldOMwlHn
Content-Disposition: attachment; filename=i2cdump-0x57.txt
Content-Type: text/plain; name=i2cdump-0x57.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 68 6e 6d ff 00 00 ff ff 00 00 00 ff 00 00 ff ff    hnm.............
10: 00 00 00 ff 00 00 ff ff 00 00 00 ff 00 00 ff ff    ................
20: 30 32 30 ff 00 00 ff ff 00 00 00 ff 00 00 ff ff    020.............
30: 00 00 00 ff 00 00 ff ff 00 00 00 ff 45 34 ff ff    ............E4..
40: 34 00 00 ff 00 00 ff ff 00 00 00 ff 00 00 ff ff    4...............
50: 00 00 00 ff 00 00 ff ff 00 00 45 ff 30 33 ff ff    ..........E.03..
60: 00 00 00 ff 00 00 ff ff 00 00 00 ff 00 00 ff ff    ................
70: 00 00 00 ff 00 00 ff ff 00 00 00 ff 00 00 ff ff    ................
80: ff ff 5a ff 5a ff ff ff fc f2 80 ff 2f ff ff ff    ..Z.Z...???./...
90: 00 00 00 ff 00 ff ff ff ff ff ff ff 80 0f ff ff    ............??..
a0: f0 d7 11 ff fe fd ff ff ed e1 ff ff ff 00 ff ff    ???.??..??......
b0: f8 ff 21 ff ff ff ff ff ff ff ff ff ff 2a ff ff    ?.!..........*..
c0: c4 ff ff ff f0 c9 ff ff ef ff ff ff c0 80 ff ff    ?...??..?...??..
d0: ff ff ff ff ca de ff ff 81 01 01 ff 81 4b ff ff    ....??..???.?K..
e0: 80 80 80 ff 80 aa ff ff ff ff ea ff fe 95 ff ff    ???.??....?.??..
f0: 4a fe 00 ff f5 ff ff ff 00 00 00 ff 5a ff ff ff    J?..?.......Z...

--=-TRDTM04jk+gcldOMwlHn
Content-Disposition: attachment; filename=i2cdump-0x69.txt
Content-Type: text/plain; name=i2cdump-0x69.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: XX 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21    X!!!!!!!!!!!!!!!
10: 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21    !!!!!!!!!!!!!!!!
20: 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21    !!!!!!!!!!!!!!!!
30: 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21    !!!!!!!!!!!!!!!!
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
80: XX 7f ff ef ef 0f 0f 75 21 07 ef 20 a5 00 00 40    X?.????u!?? ?..@
90: 32 4b 00 3c 01 8d 71 00 3c 06 8d 71 06 8d 71 06    2K.<??q.<??q??q?
a0: 0f 0f 0f 71 71 71 71 71 71 00 3c 74 00 c0 00 fe    ???qqqqqq.<t.?.?
b0: 00 40 06 df 06 df 66 fa 00 53 66 a6 00 71 71 4b    .@????f?.Sf?.qqK
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX

--=-TRDTM04jk+gcldOMwlHn
Content-Disposition: attachment; filename=i2cdump-0x70.txt
Content-Type: text/plain; name=i2cdump-0x70.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 30 00 08 04 1d 13 00 81 00 00 00 00 00 d8 06 00    0.????.?.....??.
10: 00 13 05 00 00 00 00 00 cd 01 0b 00 98 55 00 24    .??.....???.?U.$
20: 42 81 11 11 00 00 00 00 00 00 00 00 5c 98 00 ff    B???........\?..
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
40: 30 00 08 04 1d 13 00 81 00 00 00 00 00 d8 06 00    0.????.?.....??.
50: 00 13 05 00 00 00 00 00 cd 01 0b 00 98 55 00 00    .??.....???.?U..
60: 42 80 11 11 00 00 00 00 00 00 00 00 5c 98 00 ff    B???........\?..
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: 30 00 08 04 1d 13 00 81 00 00 00 00 00 d8 06 00    0.????.?.....??.
90: 00 13 05 00 00 00 00 00 cd 01 0b 00 98 55 00 00    .??.....???.?U..
a0: 42 80 11 11 00 00 00 00 00 00 00 00 5c 98 00 ff    B???........\?..
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: 30 00 08 04 1d 13 00 81 00 00 00 00 00 d8 06 00    0.????.?.....??.
d0: 00 13 05 00 00 00 00 00 cd 01 0b 00 98 55 81 00    .??.....???.?U?.
e0: 42 82 11 11 00 00 00 00 00 00 00 00 5c 98 00 ff    B???........\?..
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................

--=-TRDTM04jk+gcldOMwlHn
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--=-TRDTM04jk+gcldOMwlHn--

