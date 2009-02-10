From: Tomasz Sterna <tomek@xiaoka.com>
Date: Tue, 10 Feb 2009 14:05:51 +0000
Subject: [lm-sensors] ipmisensors for 2.6.24 kernel - ported diff
Message-Id: <1234274751.5636.291.camel@wing>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello.

I couldn't find ipmisensors module for 2.6.24 kernel, so I tried to port
ipmisensors-20060805-0622.diff
After a bit of hacking and guesswork I managed to modify it that it
compiles cleanly on 2.6.24 from Ubuntu 8.04.2 (2.6.24-23.48).

The diff is here:
http://tomasz.sterna.tv/stuff/Linux/ipmisensors-20090209-0624.diff


But after loading the ipmisensors module:
# lsmod | grep ipmi
ipmi_poweroff          10540  0 
ipmi_watchdog          20820  0 
ipmi_devintf           10248  0 
ipmisensors            19592  0 
ipmi_si                43788  2 
ipmi_msghandler        39384  5 ipmi_poweroff,ipmi_watchdog,ipmi_devintf,ipmisensors,ipmi_si


I still get no sensors:
# sensors
No sensors found!
Make sure you loaded all the kernel drivers you need.


There are some sensors in:
# ipmitool -I open sdr list
Fan 1            | 11 unspecified    | nc
Fan 2            | 11 unspecified    | nc
Fan 3            | 11 unspecified    | nc
Fan 4            | 11 unspecified    | nc
PCI Fan          | 6 unspecified     | nc
Memory           | 0 unspecified     | ok
CPU 1            | 0 unspecified     | ok
CPU 2            | 0 unspecified     | ok
VRM              | 0 unspecified     | ok
CPU1 Temperature | 31 degrees C      | ok
CPU2 Temperature | 0 degrees C       | ok
Thermal Trip     | 0 unspecified     | ok
Sys Temperature  | 29 degrees C      | ok
DDR 1.25V        | 1.26 Volts        | ok
Sys 3.3V         | disabled          | ns
Sys 5V           | 5.00 Volts        | ok
CIOBE 1.2V       | 1.23 Volts        | ok
CIOBE 2.5V       | 2.58 Volts        | ok
BIOS Progress    | disabled          | ns
Watchdog         | disabled          | ns


There is a problem in dmesg, but being unfamiliar with the IPMI itself,
I unable to find out whether I did screw up the port, or there is a
deeper problem:
# dmesg|grep 'ipmisensors:'
[   57.382986] ipmisensors: Registered IPMI 1.0 BMC over interface 0
[   57.382990] ipmisensors: Send 0x22
[   57.391675] ipmisensors: received message
[   57.391683] ipmisensors: Got first resid 0x0001
[   57.391687] ipmisensors: Get SDR 0x0 0x0 0x0
[   57.391690] ipmisensors: Send 0x23 0x0 0x0
[   57.469096] ipmisensors: received message
[   57.469105] ipmisensors: Get SDR 0x1 0x1 0x10
[   57.469108] ipmisensors: Send 0x23 0x1 0x0
[   57.489069] ipmisensors: received message
[   57.489076] ipmisensors: Get SDR 0x1 0x1 0x20
[   57.489078] ipmisensors: Send 0x23 0x1 0x0
[   57.508969] ipmisensors: received message
[   57.508972] ipmisensors: Get SDR 0x1 0x1 0x30
[   57.508975] ipmisensors: Send 0x23 0x1 0x0
[   57.528984] ipmisensors: received message
[   57.528992] ipmisensors: skipping non-threshold sensor "Fan 1           "
[   57.528995] ipmisensors: Get SDR 0x0 0x2 0x0
[   57.528997] ipmisensors: Send 0x23 0x0 0x0
[   57.606148] ipmisensors: received message
[   57.606155] ipmisensors: Get SDR 0x1 0x2 0x10
[   57.606157] ipmisensors: Send 0x23 0x1 0x0
[   57.626154] ipmisensors: received message
[   57.626157] ipmisensors: Get SDR 0x1 0x2 0x20
[   57.626158] ipmisensors: Send 0x23 0x1 0x0
[   57.646157] ipmisensors: received message
[   57.646165] ipmisensors: Get SDR 0x1 0x2 0x30
[   57.646167] ipmisensors: Send 0x23 0x1 0x0
[   57.666214] ipmisensors: received message
[   57.666221] ipmisensors: skipping non-threshold sensor "Fan 2           "
[   57.666224] ipmisensors: Get SDR 0x0 0x3 0x0
[   57.666226] ipmisensors: Send 0x23 0x0 0x0
[   57.743208] ipmisensors: received message
[   57.743210] ipmisensors: Get SDR 0x1 0x3 0x10
[   57.743212] ipmisensors: Send 0x23 0x1 0x0
[   57.763236] ipmisensors: received message
[   57.763238] ipmisensors: Get SDR 0x1 0x3 0x20
[   57.763240] ipmisensors: Send 0x23 0x1 0x0
[   57.783169] ipmisensors: received message
[   57.783172] ipmisensors: Get SDR 0x1 0x3 0x30
[   57.783174] ipmisensors: Send 0x23 0x1 0x0
[   57.803181] ipmisensors: received message
[   57.803183] ipmisensors: skipping non-threshold sensor "Fan 3           "
[   57.803185] ipmisensors: Get SDR 0x0 0x4 0x0
[   57.803187] ipmisensors: Send 0x23 0x0 0x0
[   57.880169] ipmisensors: received message
[   57.880171] ipmisensors: Get SDR 0x1 0x4 0x10
[   57.880173] ipmisensors: Send 0x23 0x1 0x0
[   57.900294] ipmisensors: received message
[   57.900296] ipmisensors: Get SDR 0x1 0x4 0x20
[   57.900298] ipmisensors: Send 0x23 0x1 0x0
[   57.920306] ipmisensors: received message
[   57.920308] ipmisensors: Get SDR 0x1 0x4 0x30
[   57.920310] ipmisensors: Send 0x23 0x1 0x0
[   57.940304] ipmisensors: received message
[   57.940306] ipmisensors: skipping non-threshold sensor "Fan 4           "
[   57.940308] ipmisensors: Get SDR 0x0 0x5 0x0
[   57.940310] ipmisensors: Send 0x23 0x0 0x0
[   58.017525] ipmisensors: received message
[   58.017533] ipmisensors: Get SDR 0x1 0x5 0x10
[   58.017536] ipmisensors: Send 0x23 0x1 0x0
[   58.037498] ipmisensors: received message
[   58.037502] ipmisensors: Get SDR 0x1 0x5 0x20
[   58.037504] ipmisensors: Send 0x23 0x1 0x0
[   58.057484] ipmisensors: received message
[   58.057490] ipmisensors: Get SDR 0x1 0x5 0x30
[   58.057494] ipmisensors: Send 0x23 0x1 0x0
[   58.077548] ipmisensors: received message
[   58.077556] ipmisensors: skipping non-threshold sensor "PCI Fan         "
[   58.077559] ipmisensors: Get SDR 0x0 0x6 0x0
[   58.077561] ipmisensors: Send 0x23 0x0 0x0
[   58.154723] ipmisensors: received message
[   58.154730] ipmisensors: Get SDR 0x1 0x6 0x10
[   58.154733] ipmisensors: Send 0x23 0x1 0x0
[   58.174722] ipmisensors: received message
[   58.174724] ipmisensors: Get SDR 0x1 0x6 0x20
[   58.174726] ipmisensors: Send 0x23 0x1 0x0
[   58.194611] ipmisensors: received message
[   58.194614] ipmisensors: Get SDR 0x1 0x6 0x30
[   58.194615] ipmisensors: Send 0x23 0x1 0x0
[   58.214583] ipmisensors: received message
[   58.214586] ipmisensors: Get SDR 0x0 0x7 0x0
[   58.214588] ipmisensors: Send 0x23 0x0 0x0
[   58.291634] ipmisensors: received message
[   58.291636] ipmisensors: Get SDR 0x1 0x7 0x10
[   58.291638] ipmisensors: Send 0x23 0x1 0x0
[   58.311562] ipmisensors: received message
[   58.311564] ipmisensors: Get SDR 0x1 0x7 0x20
[   58.311566] ipmisensors: Send 0x23 0x1 0x0
[   58.331489] ipmisensors: received message
[   58.331491] ipmisensors: Get SDR 0x1 0x7 0x30
[   58.331493] ipmisensors: Send 0x23 0x1 0x0
[   58.351317] ipmisensors: received message
[   58.351319] ipmisensors: Get SDR 0x0 0x8 0x0
[   58.351321] ipmisensors: Send 0x23 0x0 0x0
[   58.428538] ipmisensors: received message
[   58.428541] ipmisensors: Get SDR 0x1 0x8 0x10
[   58.428542] ipmisensors: Send 0x23 0x1 0x0
[   58.448483] ipmisensors: received message
[   58.448485] ipmisensors: Get SDR 0x1 0x8 0x20
[   58.448487] ipmisensors: Send 0x23 0x1 0x0
[   58.468508] ipmisensors: received message
[   58.468511] ipmisensors: Get SDR 0x1 0x8 0x30
[   58.468512] ipmisensors: Send 0x23 0x1 0x0
[   58.488519] ipmisensors: received message
[   58.488521] ipmisensors: Get SDR 0x0 0x9 0x0
[   58.488523] ipmisensors: Send 0x23 0x0 0x0
[   58.565523] ipmisensors: received message
[   58.565525] ipmisensors: Get SDR 0x1 0x9 0x10
[   58.565527] ipmisensors: Send 0x23 0x1 0x0
[   58.585548] ipmisensors: received message
[   58.585551] ipmisensors: Get SDR 0x1 0x9 0x20
[   58.585552] ipmisensors: Send 0x23 0x1 0x0
[   58.605572] ipmisensors: received message
[   58.605575] ipmisensors: Get SDR 0x1 0x9 0x30
[   58.605577] ipmisensors: Send 0x23 0x1 0x0
[   58.625581] ipmisensors: received message
[   58.625584] ipmisensors: skipping non-threshold sensor "VRM             "
[   58.625586] ipmisensors: Get SDR 0x0 0xa 0x0
[   58.625588] ipmisensors: Send 0x23 0x0 0x0
[   58.702694] ipmisensors: received message
[   58.702696] ipmisensors: Get SDR 0x1 0xa 0x10
[   58.702698] ipmisensors: Send 0x23 0x1 0x0
[   58.722685] ipmisensors: received message
[   58.722687] ipmisensors: Get SDR 0x1 0xa 0x20
[   58.722688] ipmisensors: Send 0x23 0x1 0x0
[   58.742575] ipmisensors: received message
[   58.742578] ipmisensors: Get SDR 0x1 0xa 0x30
[   58.742580] ipmisensors: Send 0x23 0x1 0x0
[   58.762610] ipmisensors: received message
[   58.762619] ipmisensors: SDR 0: type 0x01 (CPU1 Temperature)
[   58.762621] ipmisensors: Get SDR 0x0 0xb 0x0
[   58.762622] ipmisensors: Send 0x23 0x0 0x0
[   58.839870] ipmisensors: received message
[   58.839872] ipmisensors: Get SDR 0x1 0xb 0x10
[   58.839874] ipmisensors: Send 0x23 0x1 0x0
[   58.859798] ipmisensors: received message
[   58.859801] ipmisensors: Get SDR 0x1 0xb 0x20
[   58.859802] ipmisensors: Send 0x23 0x1 0x0
[   58.879811] ipmisensors: received message
[   58.879813] ipmisensors: Get SDR 0x1 0xb 0x30
[   58.879815] ipmisensors: Send 0x23 0x1 0x0
[   58.899690] ipmisensors: received message
[   58.899693] ipmisensors: SDR 1: type 0x01 (CPU2 Temperature)
[   58.899695] ipmisensors: Get SDR 0x0 0xc 0x0
[   58.899696] ipmisensors: Send 0x23 0x0 0x0
[   58.976821] ipmisensors: received message
[   58.976823] ipmisensors: Get SDR 0x1 0xc 0x10
[   58.976824] ipmisensors: Send 0x23 0x1 0x0
[   58.996834] ipmisensors: received message
[   58.996837] ipmisensors: Get SDR 0x1 0xc 0x20
[   58.996839] ipmisensors: Send 0x23 0x1 0x0
[   59.016769] ipmisensors: received message
[   59.016771] ipmisensors: Get SDR 0x1 0xc 0x30
[   59.016772] ipmisensors: Send 0x23 0x1 0x0
[   59.036678] ipmisensors: received message
[   59.036681] ipmisensors: skipping non-threshold sensor "Thermal Trip    "
[   59.036683] ipmisensors: Get SDR 0x0 0xd 0x0
[   59.036684] ipmisensors: Send 0x23 0x0 0x0
[   59.113837] ipmisensors: received message
[   59.113840] ipmisensors: Get SDR 0x1 0xd 0x10
[   59.113841] ipmisensors: Send 0x23 0x1 0x0
[   59.133845] ipmisensors: received message
[   59.133847] ipmisensors: Get SDR 0x1 0xd 0x20
[   59.133849] ipmisensors: Send 0x23 0x1 0x0
[   59.153853] ipmisensors: received message
[   59.153855] ipmisensors: Get SDR 0x1 0xd 0x30
[   59.153857] ipmisensors: Send 0x23 0x1 0x0
[   59.173779] ipmisensors: received message
[   59.173782] ipmisensors: SDR 2: type 0x01 (Sys Temperature )
[   59.173784] ipmisensors: Get SDR 0x0 0xe 0x0
[   59.173786] ipmisensors: Send 0x23 0x0 0x0
[   59.250847] ipmisensors: received message
[   59.250849] ipmisensors: Get SDR 0x1 0xe 0x10
[   59.250850] ipmisensors: Send 0x23 0x1 0x0
[   59.270819] ipmisensors: received message
[   59.270821] ipmisensors: Get SDR 0x1 0xe 0x20
[   59.270822] ipmisensors: Send 0x23 0x1 0x0
[   59.290867] ipmisensors: received message
[   59.290869] ipmisensors: Get SDR 0x1 0xe 0x30
[   59.290871] ipmisensors: Send 0x23 0x1 0x0
[   59.310863] ipmisensors: received message
[   59.310866] ipmisensors: SDR 3: type 0x02 (DDR 1.25V       )
[   59.310867] ipmisensors: Get SDR 0x0 0xf 0x0
[   59.310869] ipmisensors: Send 0x23 0x0 0x0
[   59.388007] ipmisensors: received message
[   59.388010] ipmisensors: Get SDR 0x1 0xf 0x10
[   59.388011] ipmisensors: Send 0x23 0x1 0x0
[   59.408015] ipmisensors: received message
[   59.408018] ipmisensors: Get SDR 0x1 0xf 0x20
[   59.408020] ipmisensors: Send 0x23 0x1 0x0
[   59.427900] ipmisensors: received message
[   59.427902] ipmisensors: Get SDR 0x1 0xf 0x30
[   59.427903] ipmisensors: Send 0x23 0x1 0x0
[   59.447814] ipmisensors: received message
[   59.447816] ipmisensors: SDR 4: type 0x02 (Sys 3.3V        )
[   59.447818] ipmisensors: Get SDR 0x0 0x10 0x0
[   59.447820] ipmisensors: Send 0x23 0x0 0x0
[   59.525089] ipmisensors: received message
[   59.525092] ipmisensors: Get SDR 0x1 0x10 0x10
[   59.525093] ipmisensors: Send 0x23 0x1 0x0
[   59.545107] ipmisensors: received message
[   59.545109] ipmisensors: Get SDR 0x1 0x10 0x20
[   59.545111] ipmisensors: Send 0x23 0x1 0x0
[   59.565118] ipmisensors: received message
[   59.565120] ipmisensors: Get SDR 0x1 0x10 0x30
[   59.565121] ipmisensors: Send 0x23 0x1 0x0
[   59.585022] ipmisensors: received message
[   59.585025] ipmisensors: SDR 5: type 0x02 (Sys 5V          )
[   59.585027] ipmisensors: Get SDR 0x0 0x11 0x0
[   59.585029] ipmisensors: Send 0x23 0x0 0x0
[   59.662239] ipmisensors: received message
[   59.662241] ipmisensors: Get SDR 0x1 0x11 0x10
[   59.662242] ipmisensors: Send 0x23 0x1 0x0
[   59.682274] ipmisensors: received message
[   59.682277] ipmisensors: Get SDR 0x1 0x11 0x20
[   59.682279] ipmisensors: Send 0x23 0x1 0x0
[   59.702199] ipmisensors: received message
[   59.702201] ipmisensors: Get SDR 0x1 0x11 0x30
[   59.702203] ipmisensors: Send 0x23 0x1 0x0
[   59.722115] ipmisensors: received message
[   59.722118] ipmisensors: SDR 6: type 0x02 (CIOBE 1.2V      )
[   59.722120] ipmisensors: Get SDR 0x0 0x12 0x0
[   59.722122] ipmisensors: Send 0x23 0x0 0x0
[   59.799206] ipmisensors: received message
[   59.799208] ipmisensors: Get SDR 0x1 0x12 0x10
[   59.799209] ipmisensors: Send 0x23 0x1 0x0
[   59.870673] ipmisensors: Error 0xff on cmd 0xb/0x23
[   59.870676] ipmisensors: Error 0xff on cmd 0xa/0x23; state = 2; probably fatal.

I would appreciate any help.


-- 
Tomasz Sterna
Xiaoka.com  http://www.xiaoka.com/


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
