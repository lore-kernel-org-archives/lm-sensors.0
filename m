From: cholbrook@hi-privacy.net (Charles Holbrook)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: configuration question
Message-Id: <1056986577.11786.9.camel@saint>
List-Id: <lm-sensors.vger.kernel.org>
References: <1055285973.16327.61.camel@saint>
In-Reply-To: <1055285973.16327.61.camel@saint>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks but I figured out how to get it to work no matter what board I
was using.  Below is the script I ended up with.  Kinda long but will
allow everything to show up in the same order in SNMP even if the item
returns a "0" value.

### BEGIN SCRIPT ###
A[1]="VCORE1"
A[2]="VCORE2"
A[3]="+3.3V"
A[4]="+5V"
A[5]="+12V"
A[6]="-12V"
A[7]="-5V"
A[8]="V5SB"
A[9]="VBat"
A[10]="CPUFan1"
A[11]="CPUFan2"
A[12]="SYSFan"
A[13]="CPUTemp1"
A[14]="CPUTemp2"
A[15]="SYSTemp"
A[16]="SBrTemp"
A[17]="Adapter"
A[18]="Algorithm"

for line in `sensors -f|tr -s ' '|cut -d' ' -f1,2|tr -d ' '|tr '\260'
'|'|sed s/\|F//g`
do
   NAME=`echo $line|cut -d':' -f1`
   VALUE=`echo $line|cut -d':' -f2`
   case $NAME
   in
      "VCORE1")
         A[1]=$NAME
         B[1]=$VALUE
         ;;
      "VCORE2")
         A[2]=$NAME
         B[2]=$VALUE
         ;;
      "+3.3V")
         A[3]=$NAME
         B[3]=$VALUE
         ;;
      "+5V")
         A[4]=$NAME
         B[4]=$VALUE
         ;;
      "+12V")
         A[5]=$NAME
         B[5]=$VALUE
         ;;
      "-12V")
	  A[6]=$NAME
	  B[6]=$VALUE
	  ;;
     "-5V")
         A[7]=$NAME
         B[7]=$VALUE
         ;;
      "V5SB")
         A[8]=$NAME
         B[8]=$VALUE
         ;;
      "VBat")
         A[9]=$NAME
         B[9]=$VALUE
         ;;
      "CPUFan1")
         A[10]=$NAME
         B[10]=$VALUE
         ;;
      "CPUFan2")
         A[11]=$NAME
         B[11]=$VALUE
         ;;
      "SYSFan")
         A[12]=$NAME
         B[12]=$VALUE
         ;;
      "CPUTemp1")
         A[13]=$NAME
         B[13]=$VALUE
         ;;
      "CPUTemp2")
         A[14]=$NAME
         B[14]=$VALUE
         ;;
      "SYSTemp")
         A[15]=$NAME
         B[15]=$VALUE
         ;;
      "SBrTemp")
         A[16]=$NAME
         B[16]=$VALUE
         ;;
      "Adapter")
         A[17]=$NAME
         B[17]=$VALUE
         ;;
      "Algorithm")
         A[18]=$NAME
         B[18]=$VALUE
         ;;
    "it87-isa-0290")
         ;;
      "w83782d-i2c-0-28")
         ;;
      "w83781d-isa-0290")
         ;;
      "via686a-isa-6000")
         ;;
      "lm75-i2c-0-4c")
         ;;
      "w83627hf-isa-0290")
         ;;
        *)
        echo "$NAME -- $VALUE -- No Match"
        ;;
esac
done
    echo ${A[1]}
    echo ${B[1]}
    echo ${A[2]}
    echo ${B[2]}
    echo ${A[3]}
    echo ${B[3]}
    echo ${A[4]}
    echo ${B[4]}
    echo ${A[5]}
    echo ${B[5]}
    echo ${A[6]}
    echo ${B[6]}
    echo ${A[7]}
    echo ${B[7]}
    echo ${A[8]}
    echo ${B[8]}
    echo ${A[9]}
    echo ${B[9]}
    echo ${A[10]}
    echo ${B[10]}
    echo ${A[11]}
    echo ${B[11]}
    echo ${A[12]}
    echo ${B[12]}
    echo ${A[13]}
    echo ${B[13]}
    echo ${A[14]}
    echo ${B[14]}
    echo ${A[15]}
    echo ${B[15]}
    echo ${A[16]}
    echo ${B[16]}

On Fri, 2003-06-27 at 20:09, Mark D. Studebaker wrote:
> I don't understand what your mapping is from a MIB entry to what 'sensors' handles.
> You are translating an SNMP 'set' to a config file and running 'sensors -s' ??
> I don't understand what's returning (or not returning) a 'null or bad value'.
> Perhaps you could elaborate on the functions of your script...
> 
> 
> Philip Pokorny wrote:
> > Another way to attack this would be to create some "standard" labels 
> > that your SNMP module would look for.
> > 
> > Then a user of your script would need to make sure the sensors.conf uses 
> > the "LABEL" directive to name the appropriate values correctly.  In that 
> > way, your script is independant of the chipset in use.
> > 
> > You could then create entries for -5V, 5V, 3.3V, 12V and -12V (which are 
> > the standard power supply voltages and generally available). 5V-standby, 
> > 3.3V-standby and Vbat (battery voltage) are also frequently available.
> > 
> > Then create a table? for Fan speeds and number them fan1, fan2, fan3. 
> > Some motherboards have multiple monitoring chips and can monitor as many 
> > as 6 or more fans.
> > 
> > Basically, pick a common subset of readings and then name them in a 
> > standard way.  We may be doing something along these lines for the next 
> > release of the libsensors library...
> > 
> > :v)
> > 
> > Charles Holbrook wrote:
> > 
> >> I have written a script that calls sensors parses the data and then
> >> loads that data into a MIB tree with either ucd or net SNMP.  I have run
> >> into a small problem with the via686a chipset though.  In all other
> >> chipset configs you can set an inX even if that chipset doesn't
> >> monitor(causing either a bad or null value to be returned)  However with
> >> the via686a chipset I have not been able to figure out for the life of
> >> me how to do that.  The reason I am trying to create placeholders for
> >> all values that can be monitored is so that the same MIB structure would
> >> apply across all systems.
> >>
> >> EXAMPLE:
> >> .1.3.6.1.4.1.2021.5822.20.101.20 is -5V on a system with the
> >> w83627hf-isa-0290 chipset and even if it wasn't there I could add a line
> >> for in6 creating that value.
> >>
> >> .1.3.6.1.4.1.2021.5822.20.101.20 on a via686a motherboard will return a
> >> fan RPM speed.
> >>
> >> Because of this difference I cannot actually use this to get any usefull
> >> data from my server cluster.  Having a mib return different values
> >> depending on the chipset is a bad bad thing.  Is there a set command I
> >> can use in the config script to force the via686a configuration to
> >> insert a line for -12V or for that matter any place holder I want to
> >> create?
> >>
> >> Thanks in advance.
> >>
> >>
> >>
> > 
> > 
> > 
> 
