# distb Benchmarks

## How to Run

For both ProB and distb, extract the archive `ProB.tar.gz` (benchmarked version for Linux).
For other systems download the [latest nightly build](https://www3.hhu.de/stups/downloads/prob/tcltk/nightly/).
In comparison to the binary provided in the repository, the latest nightly additionally makes use of a database in order to store most of the queue items on disk and a creeping memory leak is fixed.
Furthermore, the large amount of parameters was changed to named parameters with sane default, thus the startup instructions are different (see below).


### Standard ProB
```
/path/to/prob/probcli -mc 99999999 -p PROOF_INFO false <model that should be checked>
```

### distb

Convenience script `parB2.sh` is included.
It requires to fix the `PROBCOMMAND` variable.

#### Running distb Manually

Run once per machine:

```
/path/to/prob/lib/proxy $MASTER_IP 5000 $IP 30 $LOGFILE_PROXY $PROXY_NUMBER
```

Note that on Linux systems you might need to set the `LD_LIBRARY_PATH` variable to find the ZeroMQ libraries beforehand:
```
export LD_LIBRARY_PATH=/path/to/prob/lib
```


Run once per model checking (5000 is the beginning of the TCP ports that are used):

```
/path/to/prob/probcli -bf -zmq_master2 0 $STATES 5000 0 $MASTER_IP $LOGFILE $MODEL
```

Run as many workers as you want:

```
/path/to/prob/probcli -zmq_worker2 $MASTER_IP 5000 $PROXY_NUMBER $LOGFILE_FOR_WORKER &
```
#### Running distb Manually (nightly)

Run once per machine:

```
/path/to/prob/lib/proxy $MASTER_IP 5000 $IP 30 $LOGFILE_PROXY $PROXY_NUMBER
```

Note that on Linux systems you might need to set the `LD_LIBRARY_PATH` variable to find the ZeroMQ libraries beforehand:
```
export LD_LIBRARY_PATH=/path/to/prob/lib
```


Run once per model checking:

```
/path/to/prob/probcli -bf -zmq_master <unique identifier> $MODEL
```

Run as many workers as you want:

```
/path/to/prob/probcli -zmq_worker <unique identifier> &
```

You can fine-tune the following parameters by adding ``-p NAME VALUE`` to the corresponding call:

Parameter | Default | Description | Applicable for...
----------|---------|-------------|-------------------
port      | 5000    | TCP ports should be used starting at... | master, worker
ip        | localhost | IP of the master component | master
max_states | 0 | how many states should be checked at most (0 means all) | master
tmpdir | /tmp/ | directory for temporary files | master, worker
logdir | ./distb-logs | directory for log output | master, worker
proxynumber | 0 | which proxy should the component connect to (if multiple run on the same machine) | worker
max_states_in_memory | 1000 | how many states may be kept in memory before written into a database | worker



#### Note:
It might be necessary to increase the limits of how much shared memory may be allocated,
both per segment and overall.
This is, to our knowledge, required for Mac OS X and older versions of Ubuntu.
You can view the limits by running:

```
sysctl -a | grep shm
```

Per default, recent versions of Ubuntu set the following values:

```
kernel.shmall = 18446744073692774399
kernel.shmmax = 18446744073692774399
kernel.shmmni = 4096
```

On Mac OS X, the keys might be different and you can set them by executing:

```
sudo sysctl -w kern.sysv.shmmax=18446744073692774399
sudo sysctl -w kern.sysv.shmseg=4096
sudo sysctl -w kern.sysv.shmall=18446744073692774399
```



## Models


### `CAN_BUS_tlc.mch`

This is a model of a CAN (Controller Area Network) bus which are usually used in cars. It was written by John Colley.


### `earley_2.eventb`
This is a model of the earley parsing algorithm, written by Jean-Raymond Abrial, with the help of Dominique Cansell. The purpose was to formally derive the Earley parsing algorithm in Event-B and to establish its correctness. The model contains four refinement steps and very complicated guards. Every event corresponds to a step in the parsing algorithm. The purpose was to animate the model for a particular grammar and to reproduce the sequence in http://en.wikipedia.org/wiki/Earley_parser.


### `Hanoi.mch`
This is a model of the famous Tower of Hanoi puzzle. It uses 15 discs.


### `Hanoi10d.mch`
This is a variation of `Hanoi.mch`, but it uses only 10 discs.


### `ModeProtocolMachine_mch.eventb`

In our benchmarks, this model is referred to as "MPM".
The model was developed by Space Systems Finland as part of a Distributed System for Attitude and Orbit Control for a Single Spacecraft (DSAOCSS) System. The model was a part of the case study within the EU Project DEPLOY.

See also: 

- Dubravka Ilic, Linas Laibinis, Timo Latvala, Elena Troubitsyna, and Kimmo Varpaaniemi. Deployment in the Space Sector. In Industrial Deployment of System Engineering Methods, pages 45–62. Springer, 2013.
- Dubravka Ilic, Timo Latvala, Pauli Väisänen, Kimmo Varpaaniemi, Linas Laibinis, and Elena Troubitsyna. DEPLOY Deliverable D20 D3.1 - Report on Pilot Deployment in the Space Sector. Technical report, 2010. Available at http://www.deploy-project.eu/html/deliverables.html.
- Dubravka Ilic, Timo Latvala, Laura Nummila, Tuomas Räsänen, Pauli Väisänen, Kimmo Varpaaniemi, Linas Laibinis, Yuliya Prokhorova, Elena Troubitsyna, Alexei Iliasov, Alexander Romanovsky, Michael Butler, Asieh Salehi Fathabadi, Abdolbaghi Rezazadeh, Jean-Christophe Deprez, Renaud De Landtsheer, and Christophe Ponsard. DEPLOY Deliverable D39 D3.2 - Report on Enhanced Deployment in the Space Sector. Technical report, 2011. Available at http://www.deploy-project.eu/html/deliverables.html.

### `obsw_M001.eventb`
This model was also developed by Space Systems Finland.
It models part of a system of a Mercury Planetary Orbiter.

See also: 

- Dubravka Ilic, Linas Laibinis, Timo Latvala, Elena Troubitsyna, and Kimmo Varpaaniemi. Deployment in the Space Sector. In Industrial Deployment of System Engineering Methods, pages 45–62. Springer, 2013.
- Dubravka Ilic, Timo Latvala, Pauli Väisänen, Kimmo Varpaaniemi, Linas Laibinis, and Elena Troubitsyna. DEPLOY Deliverable D20 D3.1 - Report on Pilot Deployment in the Space Sector. Technical report, 2010. Available at http://www.deploy-project.eu/html/deliverables.html.
- Dubravka Ilic, Timo Latvala, Laura Nummila, Tuomas Räsänen, Pauli Väisänen, Kimmo Varpaaniemi, Linas Laibinis, Yuliya Prokhorova, Elena Troubitsyna, Alexei Iliasov, Alexander Romanovsky, Michael Butler, Asieh Salehi Fathabadi, Abdolbaghi Rezazadeh, Jean-Christophe Deprez, Renaud De Landtsheer, and Christophe Ponsard. DEPLOY Deliverable D39 D3.2 - Report on Enhanced Deployment in the Space Sector. Technical report, 2011. Available at http://www.deploy-project.eu/html/deliverables.html.


### `Ref5_Switch_mch.eventb`

In our benchmarks, this model is referred to as "Landing Gear".
This machine is the fifth refinement step of a model of a landing gear. The landing gear system was a case study at ABZ 2014. 

See also:
- D. Hansen, L. Ladenberger, H. Wiegard, J. Bendisposto, and M. Leuschel. Validation of the ABZ Landing Gear System Using ProB. Springer, 2014.


### `rether.eventb`

This is a model of a real time ethernet protocol. The Event-B model is a translation by Marc Büngener of a model for DiVinE.

See also:
- Chitra Venkatramani and Tzicker Chiueh. Design, Implementation, and Evaluation of a Software-based Real-time Ethernet Protocol. SIGCOMM Comput. Commun. Rev., 25(4):27–37, October 1995.


### `Train_1_beebook_TLC.mch`

This interlocking system is a variation of the model from Abrial's book. The model has a reduced state space, which was achieved by manually applying a partial order reduction.

See also:
- Jean-Raymond Abrial. Modeling in Event-B: System and Software Engineering. Cambridge University Press, New York, NY, USA, 1st edition, 2010.

