From: r.marek@assembler.cz (Rudolf Marek)
Date: Wed, 27 Sep 2006 13:49:25 +0000
Subject: [lm-sensors] coretemp - digital temperature driver for Intel
Message-Id: <451A8165.9020103@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4519A5C1.8010207@assembler.cz>
In-Reply-To: <4519A5C1.8010207@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Michael Nelson wrote:
> On Wed, Sep 27, 2006 at 12:38:30PM +0200, Rudolf Marek wrote:
>
>   
>> Find this line:
>>
>>   data->therm_status = eax;
>>
>> on next line add
>>
>>  printk("EAX from  MSR %x\n", eax);
>>
>> and find this line:
>> if (eax & 0x80000000) {
>> and on next line add
>>
>> printk("in temp condition\n");
>>     
>
> Ok, I did that, recompiled it using 
>
> make -C /lib/modules/`uname -r`/build SUBDIRS=$PWD  modules
>
> Then copied it to:
>
> /lib/modules/2.6.18/kernel/drivers/hwmon/coretemp.ko
>
> depmod -a
>
> # modprobe coretemp
> # lsmod | grep core
> #
>
> Hmmmm
>
> The end of dmesg says:
>
> kobject_add failed for coretemp.0 with -EEXIST, don't try to register things
> with the same name in the same directory.
>  [<c01b32fd>] kobject_add+0x10d/0x180
>  [<c02109f6>] device_add+0x86/0x2c0
>  [<c0213c24>] platform_device_add+0xe4/0x150
>  [<f92640c5>] coretemp_init+0xc5/0x15f [coretemp]
>  [<c0135d4c>] sys_init_module+0x12c/0x1ac0
>  [<c0102c5d>] sysenter_past_esp+0x56/0x79
> coretemp: Device addition failed (-17)
>
> What's next?
>   
I think something has been left out in kernel. Did you rmmoded the 
driver before inserting the new one?
If you rmmoded, there is some problem. Please reboot and try to load the 
driver again.

Thanks
Regards
Rudolf


