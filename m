From: Dick Middleton <dick@fouter.net>
Date: Sun, 07 Oct 2007 17:58:32 +0000
Subject: Re: [lm-sensors] k8temp does produce sensible results
Message-Id: <47091E48.8090606@fouter.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <47014943.9080104@fouter.net>
In-Reply-To: <47014943.9080104@fouter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf Marek wrote:

>> Does anybody know what is happening here and whether there is any resolution to 
>> this problem available?
> 
> Some CPUs have known Errata which says that thermal sensor is unreliable. I
> think this is your case unfortunately. Did sensors detect found some other sensor?
> 
> I know that ATI690 has some internal sensor chip too but I dont have the
> documentation.

Sensors-detect finds:

Driver `f71882fg' (should be inserted):
   Detects correctly:
   * ISA bus, address 0x600
     Chip `Fintek F71882FG/F71883FG Super IO Sensors' (confidence: 9)

Driver `k8temp' (should be inserted):
   Detects correctly:
   * Chip `AMD K8 thermal sensors' (confidence: 9)

I don't have the f71882fg driver although I am thinking that is the one I need.

I'm not sure what the k8 does - perhaps you're right - it just doesn't work.

Dick


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
