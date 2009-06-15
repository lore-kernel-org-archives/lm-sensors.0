From: geza gaz <gezagaz@yahoo.com>
Date: Mon, 15 Jun 2009 12:58:35 +0000
Subject: Re: [lm-sensors] AMD K10 yet?
Message-Id: <538155.80274.qm@web33308.mail.mud.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5082797809951011314=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--===============5082797809951011314==
Content-Type: multipart/alternative; boundary="0-1248057719-1245070715=:80274"


--0-1248057719-1245070715=:80274
Content-Type: text/plain; charset=us-ascii



>Hi, just wondered if AMD K10 chips are supported yet? I searched the list for 
>this topic and see a patch from Oct 08, but it's confusing whether this patch 
>is working or not because of some errata on AMD's part. I see we also have 
>IT8720 capability according to sensors-detect, but this is not available yet 
>for us to use either.  Is there any (other) way to monitor temperatures on 
>this platform (Asus M4N78 pro motherboard, AMD Phenom II Deneb 920 cpu)?
>
>Thanks in advance for any info :)

Hi, i also try to get CPU temp info from a system we just got. It is 
Tyan Thunder s4985g3nr-e motherboard with an additional cpu board, so we have
 8 Opterons, qadcore all. I downloaded the rewritten k8temp source and 
recompiled. Also downloaded lm_sensors 3.1.0 and installed it. Using the new 
k8temp module and the new sensors, the output i get is:

w83627hf-isa-0c00
Adapter: ISA adapter
in0:         +1.78 V  (min =  +0.00 V, max =  +4.08 V)
in1:         +1.76 V  (min =  +0.00 V, max =  +4.08 V)
in2:         +3.36 V  (min =  +2.82 V, max =  +3.79 V)
in3:         +2.96 V  (min =  +4.02 V, max =  +2.48 V)
in4:         +1.46 V  (min =  +4.08 V, max =  +4.08 V)
in5:         +1.49 V  (min =  +4.08 V, max =  +4.08 V)
in6:         +1.17 V  (min =  +4.08 V, max =  +4.08 V)
in7:         +3.33 V  (min =  +4.08 V, max =  +4.08 V)
in8:         +0.06 V  (min =  +4.08 V, max =  +4.08 V)
fan1:          0 RPM  (min =    0 RPM, div = 2)
fan2:          0 RPM  (min =    0 RPM, div = 2)
fan3:          0 RPM  (min =    0 RPM, div = 2)
temp1:       +32.0 C  (high =  -1.0 C, hyst =  -1.0 C)  sensor = thermistor
temp2:       +32.5 C  (high = +80.0 C, hyst = +75.0 C)  sensor = thermistor
temp3:       +34.5 C  (high = +80.0 C, hyst = +75.0 C)  sensor = thermistor
cpu0_vid:   +0.000 V
beep_enable:enabled

k10temp-pci-00c3
Adapter: PCI adapter
temp1:        +7.5 C                                    

k10temp-pci-00cb
Adapter: PCI adapter
temp1:       +17.5 C                                    

k10temp-pci-00d3
Adapter: PCI adapter
temp1:        +8.5 C                                    

k10temp-pci-00db
Adapter: PCI adapter
temp1:        +8.0 C                                    

k10temp-pci-00e3
Adapter: PCI adapter
temp1:       +12.0 C                                    

k10temp-pci-00eb
Adapter: PCI adapter
temp1:        +4.5 C                                    

k10temp-pci-00f3
Adapter: PCI adapter
temp1:        +4.4 C                                    

k10temp-pci-00fb
Adapter: PCI adapter
temp1:        +7.5 C


I know the temps are supposed to be relative to some value, this is just 
the point where i currently am. Also the 8 cpus, not all the cores are reported.

Peter



      
--0-1248057719-1245070715=:80274
Content-Type: text/html; charset=us-ascii

<html><head><style type="text/css"><!-- DIV {margin:0px;} --></style></head><body><div style="font-family:times new roman,new york,times,serif;font-size:12pt"><div><br></div><div style="font-family: times new roman,new york,times,serif; font-size: 12pt;"><pre>&gt;Hi, just wondered if AMD K10 chips are supported yet? I searched the list for <br>&gt;this topic and see a patch from Oct 08, but it's confusing whether this patch <br>&gt;is working or not because of some errata on AMD's part. I see we also have <br>&gt;IT8720 capability according to sensors-detect, but this is not available yet <br>&gt;for us to use either.  Is there any (other) way to monitor temperatures on <br>&gt;this platform (Asus M4N78 pro motherboard, AMD Phenom II Deneb 920 cpu)?<br>&gt;<br>&gt;Thanks in advance for any info :)<br><br>Hi, i also try to get CPU temp info from a system we just got. It is <br>Tyan Thunder s4985g3nr-e motherboard with an additional cpu board, so we
 have<br>&nbsp;8 Opterons, qadcore all. I downloaded the rewritten k8temp source and <br>recompiled. Also downloaded lm_sensors 3.1.0 and installed it. Using the new <br>k8temp module and the new sensors, the output i get is:<br><br>w83627hf-isa-0c00<br>Adapter: ISA adapter<br>in0:         +1.78 V  (min =  +0.00 V, max =  +4.08 V)<br>in1:         +1.76 V  (min =  +0.00 V, max =  +4.08 V)<br>in2:         +3.36 V  (min =  +2.82 V, max =  +3.79 V)<br>in3:         +2.96 V  (min =  +4.02 V, max =  +2.48 V)<br>in4:         +1.46 V  (min =  +4.08 V, max =  +4.08 V)<br>in5:         +1.49 V  (min =  +4.08 V, max =  +4.08 V)<br>in6:         +1.17 V  (min =  +4.08 V, max =  +4.08 V)<br>in7:         +3.33 V  (min =  +4.08 V, max =  +4.08 V)<br>in8:         +0.06 V  (min =  +4.08 V, max =  +4.08 V)<br>fan1:          0 RPM  (min =    0 RPM, div = 2)<br>fan2:          0 RPM  (min =    0 RPM, div = 2)<br>fan3:          0 RPM  (min =    0 RPM, div = 2)<br>temp1:      
 +32.0 C  (high =  -1.0 C, hyst =  -1.0 C)  sensor = thermistor<br>temp2:       +32.5 C  (high = +80.0 C, hyst = +75.0 C)  sensor = thermistor<br>temp3:       +34.5 C  (high = +80.0 C, hyst = +75.0 C)  sensor = thermistor<br>cpu0_vid:   +0.000 V<br>beep_enable:enabled<br><br>k10temp-pci-00c3<br>Adapter: PCI adapter<br>temp1:        +7.5 C                                    <br><br>k10temp-pci-00cb<br>Adapter: PCI adapter<br>temp1:       +17.5 C                                    <br><br>k10temp-pci-00d3<br>Adapter: PCI adapter<br>temp1:        +8.5 C                                    <br><br>k10temp-pci-00db<br>Adapter: PCI adapter<br>temp1:        +8.0 C                                    <br><br>k10temp-pci-00e3<br>Adapter: PCI adapter<br>temp1:       +12.0 C                                    <br><br>k10temp-pci-00eb<br>Adapter: PCI adapter<br>temp1:        +4.5 C                                    <br><br>k10temp-pci-00f3<br>Adapter: PCI
 adapter<br>temp1:        +4.4 C                                    <br><br>k10temp-pci-00fb<br>Adapter: PCI adapter<br>temp1:        +7.5 C<br><br><br>I know the temps are supposed to be relative to some value, this is just <br>the point where i currently am. Also the 8 cpus, not all the cores are reported.<br><br>Peter<br></pre></div></div><br>

      </body></html>
--0-1248057719-1245070715=:80274--


--===============5082797809951011314==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5082797809951011314==--
