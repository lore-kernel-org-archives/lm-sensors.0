From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 29 Dec 2006 14:09:37 +0000
Subject: [lm-sensors] w83793 driver ready
Message-Id: <xT2SRNdf.1167401377.8757770.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061208153817.de1c2b4c.khali@linux-fr.org>
In-Reply-To: <20061208153817.de1c2b4c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Rudolf,

On 12/28/2006, "Rudolf Marek" <r.marek at assembler.cz> wrote:

>Jean Delvare wrote:
>> On Tue, 26 Dec 2006 10:08:27 +0100, Jean Delvare wrote:
>>> I searched for "w83793g" in google. And I also searched the lm-sensors
>>> mailing list for reports of users interested in the driver. Sometimes I
>>> had to download the motherboard manual for confirmation. The list I
>>> came up with is:
>>>
>>> Tyan Tempest i5000VF (S5370)
>>> Tyan Tempest i5000PT (S5383)
>>> Supermicro PDSMU
>>> Supermicro X7DBR-3
>>> Supermicro X7DBR-E
>>> Supermicro H8DAE-2
>>
>> Add to the list:
>> Asus DSBF-D
>> Asus DSBF-D/1U
>> Asus DSBF-D/SAS
>
>I add:
>
>wget ftp://ftp.supermicro.com/utility/Supero_Doctor_III/32-Bit_Edition/AllSuperD.ini
> grep -A 6 793 AllSuperD.ini  | grep \\[_ | sort -u | tr -d _[]
>
>H8DA8-2
>H8DM8-2
>H8DMR-82
>H8QM8
>H8SMI
>H8SSL-I2
>PDSM4+
>PDSMI+
>PDSMI-LN4+
>PDSMU+
>X7DA8
>X7DAL
>X7DB8
>X7DB8-X
>X7DBN
>X7DBP
>X7DBR
>X7DBR-3
>X7DBR-8
>X7DBT
>X7DBU
>X7DBX
>X7DVA
>X7DVL
>X7DVL-3
>
>Enough ;) ?

Well done, but what we need is one cheap board. Did you check the typical
price for the motherboards you listed above? If they are all expensive
server boards, it doesn't help :(

--
Jean Delvare

