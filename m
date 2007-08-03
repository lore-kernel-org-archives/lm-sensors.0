From: Sebastian Flothow <lists@flothow.de>
Date: Fri, 03 Aug 2007 21:48:09 +0000
Subject: [lm-sensors] Andigilog aSC7621 on Intel 975XBX2 - mostly working
Message-Id: <92c1df30b17dfff3995ea85f5562ddfc@flothow.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I obtained an Intel 975XBX2 Mainboard a while ago, and finally got 
round to have a look at the sensors. I'm using the asc7xxx driver I 
found in the list archives (posted by George T. Joseph in December), 
which compiles, loads and detects the aSC7621 just fine.
The machine is equipped with an Intel Core 2 Duo E6600 and is running 
Gentoo Linux with a Xen-patched 2.6.16.49 kernel (Gentoo package 
xen-sources-2.6.16.49); sensors is version 2.10.3 with libsensors 
version 2.10.3.

sensors isn't quite happy though, the output ist just:

| asc7621-i2c-0-2e
| Adapter: SMBus I801 adapter at 2000

So I suppose it doesn't recognise the aSC7621 as a valid sensor chip, 
but there doesn't appear to be a --force option or some such to get it 
to read the values anyway. Any suggestions on this?

Meanwhile, I had a look at the input files in 
/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002e:

| magrathea 0-002e # grep . *input
| fan1_input:360

This is the CPU fan (4 wires), reading is correct.

| fan2_input:364

Intel labels this one as 'auxiliary' or 'auxiliary rear' fan, 4 wires, 
reading correct.

| fan3_input:301

Front fan, 3 wires. The reading sometimes jumps to twice this value, 
and then back again after a while. I found that this fan will speed up 
a bit when calling up the hardware monitoring screen in the BIOS, 
probably because pulse stretching gets enabled, yet it doesn't do so 
when loading the driver - maybe the driver ought to set some bit for 
pulse stretching in the aSC7621? The BIOS shows this one with about 840 
rpm.

| fan4_input:354

Rear fan, 3 wires. Same as fan3, though this one doesn't change its 
reading when stopping the fan, yet goes to 0 when disconnecting it 
entirely. However, this likely an issue of the fan (maybe pulses in 
supply voltage propagating to the tach output). About 720 rpm in BIOS.

Next, the voltages with the corresponding BIOS labels:
| in0_input:1533

V1.5

| in1_input:1187

Vccp, BIOS says 1.300 though.

| in2_input:3293

V3.3

| in3_input:4986

V5.0

| in4_input:12077

V12.0

Except for Vccp, the readings are close to what the BIOS shows.


| peci_temp1_input:-28481
| peci_temp2_input:-92501
| peci_temp3_input:-31110
| peci_temp4_input:-29297

If I'm understanding PECI correctly, these are CPU temperatures 
relative to the tripping point, and hence negative. Is this correct?
Assuming it is, 1 2 and 4 seem roughly reasonable (or do they? I ought 
to look up the 'zero' temperature for the E6600), however, these values 
don't change at all, even after several days. Is there some way to 
force a refresh?

Now, time for some cooling spray to locate the other temp sensors...

| temp1_input:33750

This is the CPU temperature. As the aSC7621 has diode inputs, does this 
mean the CPU has a traditional diode in addition to that PECI stuff?
The reading is somewhat lower than the BIOS shows, but that may be due 
to the BIOS code not making use of some power saving features.

| temp2_input:43500

This is the aSC7621 itself, located close to the CPU socket, well 
within the air flow coming from the CPU heatsink. Reading matches BIOS.

| temp3_input:41750

A diode between the RAM sockets. Matches BIOS.

| temp4_input:0

What's this? According to Documentation/hwmon/asc7xxx the aSC7621 
supports two remote diodes and its internal one - where is the fourth 
reading supposed to come from?


Regards,
Sebastian

-- 
Sebastian Flothow
sebastian@flothow.de

Because it reverses the logical flow of conversation.
 > Why is top posting frowned upon?


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
