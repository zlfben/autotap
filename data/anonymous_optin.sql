--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.14
-- Dumped by pg_dump version 9.5.14

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: backend_binparam; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backend_binparam (
    parameter_ptr_id integer NOT NULL,
    tval text NOT NULL,
    fval text NOT NULL
);


ALTER TABLE public.backend_binparam OWNER TO postgres;

--
-- Name: backend_capability; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backend_capability (
    id integer NOT NULL,
    name character varying(30) NOT NULL,
    commandlabel text,
    eventlabel text,
    statelabel text,
    readable boolean NOT NULL,
    writeable boolean NOT NULL
);


ALTER TABLE public.backend_capability OWNER TO postgres;

--
-- Name: backend_capability_channels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backend_capability_channels (
    id integer NOT NULL,
    capability_id integer NOT NULL,
    channel_id integer NOT NULL
);


ALTER TABLE public.backend_capability_channels OWNER TO postgres;

--
-- Name: backend_capability_channels_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.backend_capability_channels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.backend_capability_channels_id_seq OWNER TO postgres;

--
-- Name: backend_capability_channels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.backend_capability_channels_id_seq OWNED BY public.backend_capability_channels.id;


--
-- Name: backend_capability_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.backend_capability_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.backend_capability_id_seq OWNER TO postgres;

--
-- Name: backend_capability_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.backend_capability_id_seq OWNED BY public.backend_capability.id;


--
-- Name: backend_channel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backend_channel (
    id integer NOT NULL,
    name character varying(30) NOT NULL,
    icon text
);


ALTER TABLE public.backend_channel OWNER TO postgres;

--
-- Name: backend_channel_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.backend_channel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.backend_channel_id_seq OWNER TO postgres;

--
-- Name: backend_channel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.backend_channel_id_seq OWNED BY public.backend_channel.id;


--
-- Name: backend_colorparam; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backend_colorparam (
    parameter_ptr_id integer NOT NULL,
    mode text NOT NULL
);


ALTER TABLE public.backend_colorparam OWNER TO postgres;

--
-- Name: backend_condition; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backend_condition (
    id integer NOT NULL,
    val text NOT NULL,
    comp text NOT NULL,
    par_id integer NOT NULL,
    trigger_id integer NOT NULL
);


ALTER TABLE public.backend_condition OWNER TO postgres;

--
-- Name: backend_condition_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.backend_condition_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.backend_condition_id_seq OWNER TO postgres;

--
-- Name: backend_condition_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.backend_condition_id_seq OWNED BY public.backend_condition.id;


--
-- Name: backend_device; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backend_device (
    id integer NOT NULL,
    name character varying(32) NOT NULL,
    owner_id integer NOT NULL,
    public boolean NOT NULL,
    icon text
);


ALTER TABLE public.backend_device OWNER TO postgres;

--
-- Name: backend_device_caps; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backend_device_caps (
    id integer NOT NULL,
    device_id integer NOT NULL,
    capability_id integer NOT NULL
);


ALTER TABLE public.backend_device_caps OWNER TO postgres;

--
-- Name: backend_device_capabilities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.backend_device_capabilities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.backend_device_capabilities_id_seq OWNER TO postgres;

--
-- Name: backend_device_capabilities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.backend_device_capabilities_id_seq OWNED BY public.backend_device_caps.id;


--
-- Name: backend_device_chans; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backend_device_chans (
    id integer NOT NULL,
    device_id integer NOT NULL,
    channel_id integer NOT NULL
);


ALTER TABLE public.backend_device_chans OWNER TO postgres;

--
-- Name: backend_device_chans_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.backend_device_chans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.backend_device_chans_id_seq OWNER TO postgres;

--
-- Name: backend_device_chans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.backend_device_chans_id_seq OWNED BY public.backend_device_chans.id;


--
-- Name: backend_device_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.backend_device_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.backend_device_id_seq OWNER TO postgres;

--
-- Name: backend_device_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.backend_device_id_seq OWNED BY public.backend_device.id;


--
-- Name: backend_durationparam; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backend_durationparam (
    parameter_ptr_id integer NOT NULL,
    maxhours integer,
    maxmins integer,
    maxsecs integer,
    comp boolean NOT NULL
);


ALTER TABLE public.backend_durationparam OWNER TO postgres;

--
-- Name: backend_esrule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backend_esrule (
    action_id integer NOT NULL,
    "Etrigger_id" integer NOT NULL,
    rule_ptr_id integer NOT NULL
);


ALTER TABLE public.backend_esrule OWNER TO postgres;

--
-- Name: backend_esrule_Striggers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."backend_esrule_Striggers" (
    id integer NOT NULL,
    esrule_id integer NOT NULL,
    trigger_id integer NOT NULL
);


ALTER TABLE public."backend_esrule_Striggers" OWNER TO postgres;

--
-- Name: backend_esrule_triggersS_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."backend_esrule_triggersS_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."backend_esrule_triggersS_id_seq" OWNER TO postgres;

--
-- Name: backend_esrule_triggersS_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."backend_esrule_triggersS_id_seq" OWNED BY public."backend_esrule_Striggers".id;


--
-- Name: backend_inputparam; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backend_inputparam (
    parameter_ptr_id integer NOT NULL,
    inputtype text NOT NULL
);


ALTER TABLE public.backend_inputparam OWNER TO postgres;

--
-- Name: backend_metaparam; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backend_metaparam (
    parameter_ptr_id integer NOT NULL,
    is_event boolean NOT NULL
);


ALTER TABLE public.backend_metaparam OWNER TO postgres;

--
-- Name: backend_parameter; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backend_parameter (
    id integer NOT NULL,
    name text NOT NULL,
    type text NOT NULL,
    cap_id integer NOT NULL
);


ALTER TABLE public.backend_parameter OWNER TO postgres;

--
-- Name: backend_parameter_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.backend_parameter_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.backend_parameter_id_seq OWNER TO postgres;

--
-- Name: backend_parameter_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.backend_parameter_id_seq OWNED BY public.backend_parameter.id;


--
-- Name: backend_parval; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backend_parval (
    id integer NOT NULL,
    val text NOT NULL,
    par_id integer NOT NULL,
    state_id integer NOT NULL
);


ALTER TABLE public.backend_parval OWNER TO postgres;

--
-- Name: backend_parval_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.backend_parval_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.backend_parval_id_seq OWNER TO postgres;

--
-- Name: backend_parval_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.backend_parval_id_seq OWNED BY public.backend_parval.id;


--
-- Name: backend_rangeparam; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backend_rangeparam (
    parameter_ptr_id integer NOT NULL,
    min integer NOT NULL,
    max integer NOT NULL,
    "interval" double precision NOT NULL
);


ALTER TABLE public.backend_rangeparam OWNER TO postgres;

--
-- Name: backend_rule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backend_rule (
    id integer NOT NULL,
    owner_id integer NOT NULL,
    type character varying(3) NOT NULL,
    task integer NOT NULL,
    lastedit timestamp with time zone NOT NULL
);


ALTER TABLE public.backend_rule OWNER TO postgres;

--
-- Name: backend_rule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.backend_rule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.backend_rule_id_seq OWNER TO postgres;

--
-- Name: backend_rule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.backend_rule_id_seq OWNED BY public.backend_rule.id;


--
-- Name: backend_safetyprop; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backend_safetyprop (
    id integer NOT NULL,
    type integer NOT NULL,
    owner_id integer NOT NULL,
    always boolean NOT NULL,
    task integer NOT NULL,
    lastedit timestamp with time zone NOT NULL
);


ALTER TABLE public.backend_safetyprop OWNER TO postgres;

--
-- Name: backend_safetyprop_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.backend_safetyprop_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.backend_safetyprop_id_seq OWNER TO postgres;

--
-- Name: backend_safetyprop_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.backend_safetyprop_id_seq OWNED BY public.backend_safetyprop.id;


--
-- Name: backend_setparam; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backend_setparam (
    parameter_ptr_id integer NOT NULL,
    numopts integer NOT NULL
);


ALTER TABLE public.backend_setparam OWNER TO postgres;

--
-- Name: backend_setparamopt; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backend_setparamopt (
    id integer NOT NULL,
    value text NOT NULL,
    param_id integer NOT NULL
);


ALTER TABLE public.backend_setparamopt OWNER TO postgres;

--
-- Name: backend_setparamopt_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.backend_setparamopt_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.backend_setparamopt_id_seq OWNER TO postgres;

--
-- Name: backend_setparamopt_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.backend_setparamopt_id_seq OWNED BY public.backend_setparamopt.id;


--
-- Name: backend_sp1; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backend_sp1 (
    safetyprop_ptr_id integer NOT NULL
);


ALTER TABLE public.backend_sp1 OWNER TO postgres;

--
-- Name: backend_sp1_triggers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backend_sp1_triggers (
    id integer NOT NULL,
    sp1_id integer NOT NULL,
    trigger_id integer NOT NULL
);


ALTER TABLE public.backend_sp1_triggers OWNER TO postgres;

--
-- Name: backend_sp1_triggers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.backend_sp1_triggers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.backend_sp1_triggers_id_seq OWNER TO postgres;

--
-- Name: backend_sp1_triggers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.backend_sp1_triggers_id_seq OWNED BY public.backend_sp1_triggers.id;


--
-- Name: backend_sp2; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backend_sp2 (
    safetyprop_ptr_id integer NOT NULL,
    comp text,
    "time" integer,
    state_id integer NOT NULL
);


ALTER TABLE public.backend_sp2 OWNER TO postgres;

--
-- Name: backend_sp2_conds; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backend_sp2_conds (
    id integer NOT NULL,
    sp2_id integer NOT NULL,
    trigger_id integer NOT NULL
);


ALTER TABLE public.backend_sp2_conds OWNER TO postgres;

--
-- Name: backend_sp2_conds_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.backend_sp2_conds_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.backend_sp2_conds_id_seq OWNER TO postgres;

--
-- Name: backend_sp2_conds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.backend_sp2_conds_id_seq OWNED BY public.backend_sp2_conds.id;


--
-- Name: backend_sp3; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backend_sp3 (
    safetyprop_ptr_id integer NOT NULL,
    comp text,
    occurrences integer,
    "time" integer,
    event_id integer NOT NULL,
    timecomp text
);


ALTER TABLE public.backend_sp3 OWNER TO postgres;

--
-- Name: backend_sp3_conds; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backend_sp3_conds (
    id integer NOT NULL,
    sp3_id integer NOT NULL,
    trigger_id integer NOT NULL
);


ALTER TABLE public.backend_sp3_conds OWNER TO postgres;

--
-- Name: backend_sp3_conds_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.backend_sp3_conds_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.backend_sp3_conds_id_seq OWNER TO postgres;

--
-- Name: backend_sp3_conds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.backend_sp3_conds_id_seq OWNED BY public.backend_sp3_conds.id;


--
-- Name: backend_ssrule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backend_ssrule (
    priority integer NOT NULL,
    action_id integer NOT NULL,
    rule_ptr_id integer NOT NULL
);


ALTER TABLE public.backend_ssrule OWNER TO postgres;

--
-- Name: backend_ssrule_triggers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backend_ssrule_triggers (
    id integer NOT NULL,
    ssrule_id integer NOT NULL,
    trigger_id integer NOT NULL
);


ALTER TABLE public.backend_ssrule_triggers OWNER TO postgres;

--
-- Name: backend_ssrule_triggers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.backend_ssrule_triggers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.backend_ssrule_triggers_id_seq OWNER TO postgres;

--
-- Name: backend_ssrule_triggers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.backend_ssrule_triggers_id_seq OWNED BY public.backend_ssrule_triggers.id;


--
-- Name: backend_state; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backend_state (
    id integer NOT NULL,
    cap_id integer NOT NULL,
    dev_id integer NOT NULL,
    action boolean NOT NULL,
    text text,
    chan_id integer
);


ALTER TABLE public.backend_state OWNER TO postgres;

--
-- Name: backend_state_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.backend_state_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.backend_state_id_seq OWNER TO postgres;

--
-- Name: backend_state_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.backend_state_id_seq OWNED BY public.backend_state.id;


--
-- Name: backend_statelog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backend_statelog (
    id integer NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    is_current boolean NOT NULL,
    cap_id integer NOT NULL,
    dev_id integer NOT NULL,
    value text NOT NULL,
    param_id integer NOT NULL
);


ALTER TABLE public.backend_statelog OWNER TO postgres;

--
-- Name: backend_statelog_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.backend_statelog_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.backend_statelog_id_seq OWNER TO postgres;

--
-- Name: backend_statelog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.backend_statelog_id_seq OWNED BY public.backend_statelog.id;


--
-- Name: backend_timeparam; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backend_timeparam (
    parameter_ptr_id integer NOT NULL,
    mode text NOT NULL
);


ALTER TABLE public.backend_timeparam OWNER TO postgres;

--
-- Name: backend_trigger; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backend_trigger (
    id integer NOT NULL,
    cap_id integer NOT NULL,
    dev_id integer NOT NULL,
    chan_id integer,
    pos integer,
    text text
);


ALTER TABLE public.backend_trigger OWNER TO postgres;

--
-- Name: backend_trigger_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.backend_trigger_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.backend_trigger_id_seq OWNER TO postgres;

--
-- Name: backend_trigger_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.backend_trigger_id_seq OWNED BY public.backend_trigger.id;


--
-- Name: backend_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backend_user (
    id integer NOT NULL,
    name character varying(30),
    mode character varying(5) NOT NULL,
    code text NOT NULL
);


ALTER TABLE public.backend_user OWNER TO postgres;

--
-- Name: backend_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.backend_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.backend_user_id_seq OWNER TO postgres;

--
-- Name: backend_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.backend_user_id_seq OWNED BY public.backend_user.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_capability ALTER COLUMN id SET DEFAULT nextval('public.backend_capability_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_capability_channels ALTER COLUMN id SET DEFAULT nextval('public.backend_capability_channels_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_channel ALTER COLUMN id SET DEFAULT nextval('public.backend_channel_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_condition ALTER COLUMN id SET DEFAULT nextval('public.backend_condition_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_device ALTER COLUMN id SET DEFAULT nextval('public.backend_device_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_device_caps ALTER COLUMN id SET DEFAULT nextval('public.backend_device_capabilities_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_device_chans ALTER COLUMN id SET DEFAULT nextval('public.backend_device_chans_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."backend_esrule_Striggers" ALTER COLUMN id SET DEFAULT nextval('public."backend_esrule_triggersS_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_parameter ALTER COLUMN id SET DEFAULT nextval('public.backend_parameter_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_parval ALTER COLUMN id SET DEFAULT nextval('public.backend_parval_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_rule ALTER COLUMN id SET DEFAULT nextval('public.backend_rule_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_safetyprop ALTER COLUMN id SET DEFAULT nextval('public.backend_safetyprop_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_setparamopt ALTER COLUMN id SET DEFAULT nextval('public.backend_setparamopt_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_sp1_triggers ALTER COLUMN id SET DEFAULT nextval('public.backend_sp1_triggers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_sp2_conds ALTER COLUMN id SET DEFAULT nextval('public.backend_sp2_conds_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_sp3_conds ALTER COLUMN id SET DEFAULT nextval('public.backend_sp3_conds_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_ssrule_triggers ALTER COLUMN id SET DEFAULT nextval('public.backend_ssrule_triggers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_state ALTER COLUMN id SET DEFAULT nextval('public.backend_state_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_statelog ALTER COLUMN id SET DEFAULT nextval('public.backend_statelog_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_trigger ALTER COLUMN id SET DEFAULT nextval('public.backend_trigger_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_user ALTER COLUMN id SET DEFAULT nextval('public.backend_user_id_seq'::regclass);


--
-- Data for Name: backend_binparam; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backend_binparam (parameter_ptr_id, tval, fval) FROM stdin;
1	On	Off
12	Locked	Unlocked
13	Open	Closed
14	Motion	No Motion
20	Raining	Not Raining
25	Yes	No
26	On	Off
40	On	Off
62	Day	Night
64	On	Off
65	Open	Closed
66	Smoke Detected	No Smoke Detected
67	Open	Closed
68	Awake	Asleep
72	On	Off
\.


--
-- Data for Name: backend_capability; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backend_capability (id, name, commandlabel, eventlabel, statelabel, readable, writeable) FROM stdin;
28	Record	({DEVICE}) {value/T|start}{value/F|stop} recording	{DEVICE} {value/T|starts}{value/F|stops} recording	{DEVICE} is{value/F| not} recording	t	t
36	Channel	Tune {DEVICE} to Channel {channel}	{DEVICE} {channel/=|becomes tuned to}{channel/!=|becomes tuned to something other than}{channel/>|becomes tuned above}{channel/<|becomes tuned below} {channel}	{DEVICE} is {channel/=|tuned to}{channel/!=|not tuned to}{channel/>|tuned above}{channel/<|tuned below} Channel {channel}	t	t
65	Oven Temperature	Set {DEVICE}'s temperature to {temperature}	{DEVICE}'s temperature {temperature/=|becomes}{temperature/!=|changes from}{temperature/>|goes above}{temperature/<|falls below} {temperature} degrees	{DEVICE}'s temperature {temperature/=|is}{temperature/!=|is not}{temperature/>|is above}{temperature/<|is below} {temperature} degrees	t	t
27	Alarm Ringing	{value/T|Set off}{value/F|Turn off} {DEVICE}'s alarm	{DEVICE}'s Alarm {value/T|Starts}{value/F|Stops} going off	{DEVICE}'s Alarm is{value/F| not} going off	t	t
38	How Much Coffee Is There?	\N	({DEVICE}) The number of cups of coffee {cups/=|becomes}{cups/!=|changes from}{cups/>|becomes larger than}{cups/<|falls below} {cups}	({DEVICE}) There are {cups/=|exactly}{cups/!=|not exactly}{cups/>|more than}{cups/<|fewer than} {cups} cups of coffee brewed	t	f
18	Weather Sensor	\N	({DEVICE}) The weather {weather/=|becomes}{weather/!=|stops being} {weather}	({DEVICE}) The weather is{weather/!=| not} {weather}	t	f
62	Heart Rate Sensor	\N	({DEVICE}) My heart rate {BPM/=|becomes}{BPM/!=|changes from}{BPM/>|goes above}{BPM/<|falls below} {BPM}BPM	({DEVICE}) My heart rate is {BPM/=|exactly}{BPM/!=|not}{BPM/>|above}{BPM/<|below} {BPM}BPM	t	f
32	Track Package	\N	({DEVICE}) Package #{trackingid} {distance/=|becomes}{distance/!=|stops being}{distance/>|becomes farther than}{distance/<|becomes closer than} {distance} miles away	({DEVICE}) Package #{trackingid} is{distance/!=| not} {distance/<|<}{distance/>|>}{distance} miles away	t	f
12	FM Tuner	Tune {DEVICE} to {frequency}FM	{DEVICE} {frequency/=|becomes tuned to}{frequency/!=|stops being tuned to}{frequency/>|becomes tuned above}{frequency/<|becomes tuned below} {frequency}FM	{DEVICE} {frequency/=|is tuned to}{frequency/!=|is not tuned to}{frequency/>|is tuned above}{frequency/<|is tuned below} {frequency}FM	t	t
33	What's On My Shopping List?	\N	({DEVICE}) {item} {item/=|gets added to}{item/!=|gets removed from} my Shopping List	({DEVICE}) {item} is{item/!=| not} on my Shopping List	t	f
37	What Show is On?	\N	{name} {name/=|starts}{name/!=|stops} playing on {DEVICE}	{name} is{name/!=| not} playing on {DEVICE}	t	f
29	Take Photo	({DEVICE}) Take a photo		\N	f	t
30	Order (Amazon)	({DEVICE}) Order {quantity} {item} on Amazon		\N	f	t
31	Order Pizza	({DEVICE}) Order {quantity} {size} Pizza(s) with {topping}		\N	f	t
40	Siren	Turn {DEVICE}'s Siren {value}	{DEVICE}'s Siren turns {value}	{DEVICE}'s Siren is {value}	t	t
39	Brew Coffee	({DEVICE}) Brew {cups} cup(s) of coffee		\N	f	t
64	Water On/Off	Turn {setting} {DEVICE}'s water	{DEVICE}'s water {setting/T|Turns On}{setting/F|Turns Off}	{DEVICE}'s water is {setting/F|not }running	t	t
6	Light Color	Set {DEVICE}'s Color to {color}	{DEVICE}'s color {color/=|becomes}{color/!=|changes from} {color}	{DEVICE}'s Color {color/=|is}{color/!=|is not} {color}	t	t
26	Set Alarm	({DEVICE}) Set an Alarm for {time}	{DEVICE}'s Alarm {time/=|gets set for}{time/!=|gets set for something other than}{time/>|gets set for later than}{time/<|gets set for earlier than} {time}	{DEVICE}'s Alarm is {time/=|set for}{time/!=|not set for}{time/>|set for later than}{time/<|set for earlier than} {time}	t	t
19	Current Temperature	\N	({DEVICE}) The temperature {temperature/=|becomes}{temperature/!=|changes from}{temperature/>|goes above}{temperature/<|falls below} {temperature} degrees	({DEVICE}) The temperature {temperature/=|is}{temperature/!=|is not}{temperature/>|is above}{temperature/<|is below} {temperature} degrees	t	f
50	Event Frequency	\N	It becomes true that "{$trigger$}" has {occurrences/!=|not occurred}{occurrences/=|occurred}{occurrences/>|occurred more than}{occurrences/<|occurred fewer than} {occurrences} times in the last {time}	"{$trigger$}" has {occurrences/=|occurred exactly}{occurrences/!=|not occurred exactly}{occurrences/>|occurred more than}{occurrences/<|occurred fewer than} {occurrences} times in the last {time}	t	f
9	Genre	Start playing {genre} on {DEVICE}	{DEVICE} {genre/=|starts}{genre/!=|stops} playing {genre}	{DEVICE} is{genre/!=| not} playing {genre}	t	t
13	Lock/Unlock	{setting/T|Lock}{setting/F|Unlock} {DEVICE}	{DEVICE} {setting/T|Locks}{setting/F|Unlocks}	{DEVICE} is {setting}	t	t
14	Open/Close Window	{position/T|Open}{position/F|Close} {DEVICE}	{DEVICE} {position/T|Opens}{position/F|Closes}	{DEVICE} is {position}	t	t
15	Detect Motion	\N	{DEVICE} {status/T|Starts}{status/F|Stops} Detecting Motion	{DEVICE} {status/T|detects}{status/F|does not detect} motion	t	f
20	Is it Raining?	\N	It {condition/T|starts}{condition/F|stops} raining	It is {condition}	t	f
35	Play Music	Start playing {name} on {DEVICE}	{name} {name/=|starts}{name/!=|stops} playing on {DEVICE}	{name} is {name/!=|not }playing on {DEVICE}	t	t
49	Previous State	\N	It becomes true that "{$trigger$}" was active {time} ago	"{$trigger$}" was active {time} ago	t	f
51	Time Since State	\N	It becomes true that "{$trigger$}" was last in effect {time/>|more than}{time/<|less than}{time/=|exactly} {time} ago	"{$trigger$}" was last in effect {time/>|more than}{time/<|less than}{time/=|exactly} {time} ago	t	f
52	Time Since Event	\N	It becomes true that "{$trigger$}" last happened {time/>|more than}{time/<|less than}{time/=|exactly} {time} ago	"{$trigger$}" last happened {time/>|more than}{time/<|less than}{time/=|exactly} {time} ago	t	f
55	Is it Daytime?	\N	It becomes {time}time	It is {time}time	t	f
56	Stop Music	Stop playing music on {DEVICE}		\N	f	t
57	AC On/Off	Turn {setting} the AC	The AC turns {setting}	The AC is {setting}	t	t
58	Open/Close Curtains	{position/T|Open}{position/F|Close} {DEVICE}'s Curtains	{DEVICE}'s curtains {position/T|Open}{position/F|Close}	{DEVICE}'s curtains are {position}	t	t
59	Smoke Detection	\N	{DEVICE} {condition/T|Starts}{condition/F|Stops} detecting smoke	({DEVICE}) {condition/F|No }Smoke is Detected	t	f
60	Open/Close Door	{position/T|Open}{position/F|Close} {DEVICE}'s Door	{DEVICE}'s door {position/T|Opens}{position/F|Closes}	{DEVICE}'s door is {position}	t	t
61	Sleep Sensor	\N	({DEVICE}) I {status/T|Wake Up}{status/F|Fall Asleep}	({DEVICE}) I am {status}	t	f
63	Detect Presence	\N	{who/=|}{who/!=|Someone other than }{who} {location/=|Enters}{location/!=|Exits} {location}	{who/!=|Someone other than }{who} is {location/!=|not }in {location}	t	f
21	Thermostat	Set {DEVICE} to {temperature}	{DEVICE}'s temperature {temperature/=|becomes set to}{temperature/!=|changes from being set to}{temperature/>|becomes set above}{temperature/<|becomes set below} {temperature} degrees	{DEVICE} is {temperature/!=|not set to}{temperature/=|set to}{temperature/>|set above}{temperature/<|set below} {temperature} degrees	t	t
3	Brightness	Set {DEVICE}'s Brightness to {level}	{DEVICE}'s brightness {level/=|becomes}{level/!=|stops being}{level/>|goes above}{level/<|falls below} {level}	{DEVICE}'s Brightness {level/=|is}{level/!=|is not}{level/>|is above}{level/<|is below} {level}	t	t
8	Volume	Set {DEVICE}'s Volume to {level}	{DEVICE}'s Volume {level/=|becomes}{level/!=|changes from}{level/>|goes above}{level/<|falls below} {level}	{DEVICE}'s Volume {level/=|is}{level/!=|is not}{level/>|is above}{level/<|is below} {level}	t	t
25	Clock	\N	({DEVICE}) The time {time/=|becomes}{time/!=|changes from}{time/>|becomes later than}{time/<|becomes earlier than} {time}	({DEVICE}) The time {time/=|is}{time/!=|is not}{time/>|is after}{time/<|is before} {time}	t	f
2	Power On/Off	Turn {DEVICE} {setting}	{DEVICE} turns {setting}	{DEVICE} is {setting}	t	t
66	Temperature Control	Set {DEVICE}'s temperature to {temperature}	{DEVICE}'s temperature {temperature/=|becomes set to}{temperature/!=|becomes set to something other than}{temperature/>|becomes set above}{temperature/<|becomes set below} {temperature} degrees	{DEVICE}'s temperature is {temperature/=|set to}{temperature/!=|not set to}{temperature/>|set above}{temperature/<|set below} {temperature} degrees	t	t
\.


--
-- Data for Name: backend_capability_channels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backend_capability_channels (id, capability_id, channel_id) FROM stdin;
9	2	1
11	3	2
12	6	2
14	8	3
15	9	3
16	12	3
17	13	4
18	14	5
19	8	12
20	15	6
23	18	6
24	18	7
25	19	8
26	19	6
27	20	7
28	21	8
30	25	9
31	26	9
32	27	9
33	28	10
34	29	10
35	30	11
36	31	11
37	31	13
38	32	11
39	33	11
40	35	3
41	36	12
42	37	12
43	38	13
44	39	13
45	40	4
50	49	14
51	50	14
52	51	14
53	52	14
56	55	9
57	56	3
58	21	13
59	57	8
60	58	5
61	59	6
62	2	2
63	2	3
64	2	12
65	2	13
66	60	13
67	60	5
68	61	16
69	61	6
70	62	16
71	62	6
72	63	6
73	63	15
74	64	17
75	64	13
76	65	13
77	19	13
78	66	8
79	66	13
80	2	18
81	13	13
82	13	5
\.


--
-- Name: backend_capability_channels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backend_capability_channels_id_seq', 82, true);


--
-- Name: backend_capability_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backend_capability_id_seq', 67, true);


--
-- Data for Name: backend_channel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backend_channel (id, name, icon) FROM stdin;
6	Sensors	visibility
7	Weather	filter_drama
8	Temperature	ac_unit
9	Time	access_time
11	Shopping	shopping_cart
12	Television	tv
1	Power	power_settings_new
2	Lights	wb_incandescent
3	Music	library_music
4	Security	lock
15	Location	room
14	History	hourglass_empty
17	Water & Plumbing	local_drink
5	Windows & Doors	meeting_room
16	Health	favorite_border
10	Camera	photo_camera
13	Food & Cooking	fastfood
18	Cleaning	build
\.


--
-- Name: backend_channel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backend_channel_id_seq', 18, true);


--
-- Data for Name: backend_colorparam; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backend_colorparam (parameter_ptr_id, mode) FROM stdin;
\.


--
-- Data for Name: backend_condition; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backend_condition (id, val, comp, par_id, trigger_id) FROM stdin;
104	Open	=	67	94
105	Open	=	67	95
106	On	=	72	96
107	Open	=	13	97
108	On	=	72	98
110	On	=	1	100
112	On	=	26	102
113	Open	=	67	103
114	Kitchen	=	70	104
115	Bobby	=	71	104
119	On	=	1	107
120	On	=	1	108
123	Open	=	67	111
124	Open	=	67	112
126	Red	!=	3	114
127	On	=	72	115
128	Open	=	13	116
129	70	>	18	117
130	Open	=	13	118
131	Raining	=	20	119
133	Home	=	70	121
134	Anyone	=	71	121
135	Pop	=	8	122
139	Open	=	65	126
41	Asleep	=	68	41
42	On	=	1	42
43	22	=	69	43
44	Red	=	3	44
140	On	=	1	127
46	Living Room	=	70	46
47	Anyone	=	71	46
142	Open	=	13	129
143	On	=	1	130
51	On	=	72	50
52	Kitchen	=	70	51
53	Anyone	=	71	51
144	Asleep	=	68	131
56	Red	!=	3	54
57	On	=	72	55
58	Kitchen	=	70	56
59	Anyone	=	71	56
60	Kitchen	=	70	57
61	Anyone	=	71	57
62	Kitchen	=	70	58
63	Anyone	=	71	58
64	Kitchen	=	70	59
65	Anyone	=	71	59
145	On	=	1	132
67	Asleep	=	68	61
68	Red	=	3	62
146	Asleep	=	68	133
147	On	=	1	134
148	Asleep	=	68	135
72	Open	=	67	66
74	Off	=	64	68
75	On	=	26	69
76	On	=	26	70
77	On	=	26	71
150	Asleep	=	68	137
79	On	=	26	73
80	28	<	73	74
151	On	=	1	138
152	Asleep	=	68	139
154	Asleep	=	68	141
155	Asleep	=	68	142
86	Open	=	67	80
87	Kitchen	=	70	81
88	Bobby	=	71	81
91	Awake	=	68	84
156	On	=	1	143
162	1	=	73	149
163	Open	=	13	150
164	Raining	=	20	151
165	Open	=	13	152
166	70	>	18	153
167	80	<	18	154
168	Open	=	13	155
169	70	>	18	156
170	80	<	18	157
171	Not Raining	=	20	158
172	Open	=	13	159
173	Raining	=	20	160
175	Raining	=	20	162
176	Open	=	67	163
177	Kitchen	=	70	164
178	Bobbie	=	71	164
179	80	<	21	165
180	80	<	21	166
181	40	<	18	167
182	Raining	=	20	168
183	Open	=	13	169
184	Open	=	67	170
185	Open	=	13	171
186	80	<	18	172
187	70	>	18	173
188	Not Raining	=	20	174
189	70	>	21	175
190	Home	=	70	176
191	Anyone	=	71	176
192	70	>	21	177
193	Home	=	70	178
194	Anyone	=	71	178
195	75	<	21	179
196	Home	=	70	180
197	Anyone	=	71	180
198	Open	=	65	181
199	Pop	=	8	182
200	On	=	1	183
201	Open	=	65	184
202	Unlocked	=	12	185
203	Home	!=	70	186
204	Family Member	=	71	186
205	Unlocked	=	12	187
206	Home	!=	70	188
207	A Family Member	=	71	188
208	On	=	1	189
209	Home	=	70	190
210	A Guest	=	71	190
214	On	=	1	193
216	Bedroom	=	70	195
217	Bobbie	=	71	195
218	On	=	1	196
219	Night	=	62	197
220	Off	=	1	198
221	On	=	1	199
222	Off	=	1	200
226	On	=	1	204
227	Night	=	62	205
232	On	=	26	209
233	On	=	1	210
234	On	=	1	211
237	On	=	1	214
239	On	=	1	216
240	On	=	1	217
242	Open	=	13	219
243	Raining	=	20	220
245	Open	=	13	222
246	Closed	=	13	223
247	Closed	=	13	224
248	Closed	=	13	225
249	Closed	=	13	226
250	Closed	=	13	227
251	Closed	=	13	228
252	Closed	=	13	229
253	Closed	=	13	230
254	Closed	=	13	231
255	Open	=	67	232
256	Kitchen	=	70	233
257	Bobbie	=	71	233
258	Kitchen	=	70	234
259	Bobbie	=	71	234
260	Open	=	67	235
261	80	>	18	236
262	40	<	18	237
366	60	>	18	324
367	80	<	18	325
263	{'channel': {'name': 'Water & Plumbing', 'id': 17, 'icon': 'local_drink'}, 'parameters': [{'name': 'setting', 'type': 'bin', 'id': 72, 'values': ['On', 'Off']}], 'device': {'name': 'Smart Faucet', 'id': 22}, 'capability': {'name': 'Water On/Off', 'id': 64, 'label': "{DEVICE}'s water is {setting/F|not }running"}, 'parameterVals': [{'comparator': '=', 'value': 'Off'}], 'text': "Smart Faucet's water is not running"}	=	55	238
264	{'seconds': 0, 'hours': 0, 'minutes': 1}	=	56	238
265	{'channel': {'name': 'Water & Plumbing', 'id': 17, 'icon': 'local_drink'}, 'parameters': [{'name': 'setting', 'type': 'bin', 'id': 72, 'values': ['On', 'Off']}], 'device': {'name': 'Smart Faucet', 'id': 22}, 'capability': {'name': 'Water On/Off', 'id': 64, 'label': "{DEVICE}'s water is {setting/F|not }running"}, 'parameterVals': [{'comparator': '=', 'value': 'Off'}], 'text': "Smart Faucet's water is not running"}	=	55	239
266	{'seconds': 0, 'hours': 0, 'minutes': 5}	=	56	239
267	80	<	18	240
268	70	>	18	241
269	Clear	=	17	242
270	Closed	=	13	243
271	70	>	18	244
272	80	<	18	245
273	Clear	=	17	246
274	Closed	=	13	247
275	Clear	=	17	248
276	80	<	18	249
277	70	>	18	250
278	Closed	=	13	251
279	Closed	=	13	252
280	80	<	18	253
281	70	>	18	254
282	Clear	=	17	255
283	On	=	1	256
284	Home	=	70	257
285	A Guest	=	71	257
287	On	=	1	259
288	On	=	1	260
289	Home	=	70	261
290	Anyone	=	71	261
291	On	=	1	262
292	Home	=	70	263
293	Anyone	=	71	263
295	Home	=	70	265
296	Anyone	=	71	265
298	On	=	1	267
300	On	=	1	269
302	On	=	1	271
304	On	=	1	273
306	Home	=	70	275
307	A Family Member	=	71	275
314	Closed	=	13	280
315	Closed	=	13	281
317	Kitchen		70	283
318	Bobbie		71	283
325	40	=	18	288
328	{'text': '(FitBit) I fall asleep', 'parameterVals': [{'comparator': '=', 'value': 'Asleep'}], 'device': {'name': 'FitBit', 'id': 21}, 'parameters': [{'name': 'status', 'id': 68, 'type': 'bin', 'values': ['Awake', 'Asleep']}], 'capability': {'name': 'Sleep Sensor', 'id': 61, 'label': '({DEVICE}) I {status/T|wake up}{status/F|fall asleep}'}, 'channel': {'name': 'Health', 'id': 16, 'icon': 'favorite_border'}}	=	57	291
329	{'hours': 0, 'seconds': 0, 'minutes': 30}	>	58	291
330	On	=	1	292
332	80	<	18	294
333	Not Raining	=	20	295
334	Closed	=	13	296
337	Open	=	65	299
339	Asleep	=	68	301
341	{'text': 'A Guest enters Home', 'parameterVals': [{'comparator': '=', 'value': 'Home'}, {'comparator': ' ', 'value': 'A Guest'}], 'device': {'name': 'Location Sensor', 'id': 12}, 'parameters': [{'name': 'location', 'id': 70, 'type': 'set', 'values': ['Home', 'Kitchen', 'Bedroom', 'Bathroom', 'Living Room']}, {'name': 'who', 'id': 71, 'type': 'set', 'values': ['Anyone', 'Alice', 'Bobbie', 'A Family Member', 'A Guest']}], 'capability': {'name': 'Detect Presence', 'id': 63, 'label': '{who/!=|Someone other than }{who} {location/=|enters}{location/!=|exits} {location}'}, 'channel': {'name': 'Location', 'id': 15, 'icon': 'room'}}	=	57	303
342	{'hours': 3, 'seconds': 0, 'minutes': 0}	<	58	303
345	On	=	1	305
347	Open	=	67	307
349	Home	 	70	309
350	Anyone	 	71	309
354	Asleep	=	68	313
356	Home	 	70	315
357	A Guest	 	71	315
359	Asleep	=	68	317
361	Open	=	65	319
368	Not Raining	=	20	326
382	On	=	1	339
385	Home	 	70	342
386	A Guest	 	71	342
388	Closed	=	13	344
389	Closed	=	13	345
393	Home	 	70	349
394	Anyone	=	71	349
396	Home	 	70	351
397	Anyone	 	71	351
400	80	>	18	354
402	adam	 	37	356
403	Asleep	=	68	357
404	On	=	1	358
413	Off	=	1	365
415	On	=	1	367
419	5	>	74	371
420	Open	=	67	372
430	{'text': "Smart Faucet's water turns On", 'parameters': [{'id': 72, 'type': 'bin', 'values': ['On', 'Off'], 'name': 'setting'}], 'capability': {'label': "{DEVICE}'s water turns {setting}", 'id': 64, 'name': 'Water On/Off'}, 'device': {'id': 22, 'name': 'Smart Faucet'}, 'channel': {'icon': 'local_drink', 'id': 17, 'name': 'Water & Plumbing'}, 'parameterVals': [{'comparator': '=', 'value': 'On'}]}	=	52	381
431	{'minutes': 0, 'seconds': 15, 'hours': 0}	=	53	381
432	1	>	54	381
437	Pop	!=	8	384
439	Closed	=	13	386
440	Open	=	13	387
442	Open	=	67	389
444	On	=	1	391
451	Asleep	=	68	398
453	On	=	1	400
456	Off	=	72	403
457	Off	=	72	404
459	Closed	=	13	406
460	Closed	=	13	407
462	Closed	=	13	409
463	Closed	=	13	410
465	Off	=	72	412
467	Closed	=	13	414
468	Closed	=	13	415
469	On	=	1	416
470	15:00	<	23	417
471	00:00	>	23	418
472	80	<	18	419
474	15:00	<	23	421
475	00:00	>	23	422
476	80	<	18	423
478	Closed	=	65	425
480	On	=	1	427
482	80	>	18	429
483	80	=	18	430
484	80	>	18	431
485	80	=	18	432
487	On	=	64	434
489	Home	 	70	436
490	A Guest	 	71	436
492	Home	!=	70	438
493	Anyone	!=	71	438
495	80	=	18	440
497	Asleep	=	68	442
500	Closed	=	65	445
503	80	>	18	448
504	Home	!=	70	449
505	Anyone	=	71	449
515	Open	=	67	458
518	Locked	=	12	461
519	Asleep	=	68	462
524	Open	=	13	466
525	60	>	18	467
526	80	<	18	468
530	60	>	18	472
531	80	<	18	473
532	Not Raining	=	20	474
543	 	=	72	483
551	Closed	=	13	491
553	Closed	=	13	493
555	Closed	=	13	495
556	Open	=	67	496
557	{'text': "Smart Refrigerator's door Opens", 'parameters': [{'id': 67, 'type': 'bin', 'values': ['Open', 'Closed'], 'name': 'position'}], 'capability': {'label': "{DEVICE}'s door {position/T|Opens}{position/F|Closes}", 'id': 60, 'name': 'Open/Close Door'}, 'device': {'id': 8, 'name': 'Smart Refrigerator'}, 'channel': {'icon': 'fastfood', 'id': 13, 'name': 'Food & Cooking'}, 'parameterVals': [{'comparator': '=', 'value': 'Open'}]}	=	57	497
558	{'minutes': 2, 'seconds': 0, 'hours': 0}	=	58	497
559	81	=	21	498
560	Home	 	70	499
561	Anyone	=	71	499
562	Closed	=	13	500
563	Closed	=	13	501
565	{'text': "Smart Refrigerator's door Opens", 'parameters': [{'id': 67, 'type': 'bin', 'values': ['Open', 'Closed'], 'name': 'position'}], 'capability': {'label': "{DEVICE}'s door {position/T|Opens}{position/F|Closes}", 'id': 60, 'name': 'Open/Close Door'}, 'device': {'id': 8, 'name': 'Smart Refrigerator'}, 'channel': {'icon': 'fastfood', 'id': 13, 'name': 'Food & Cooking'}, 'parameterVals': [{'comparator': '=', 'value': 'Open'}]}	=	57	503
566	{'minutes': 2, 'seconds': 0, 'hours': 0}	=	58	503
568	Home	 	70	505
569	Anyone	=	71	505
570	Closed	=	13	506
571	Closed	=	13	507
573	Asleep	=	68	509
575	Pop	 	8	511
577		=	72	513
579	Asleep	=	68	515
590	Bedroom	 	70	525
591	Anyone	=	71	525
599	Kitchen	=	70	532
600	Bobbie	=	71	532
601	Kitchen	!=	70	533
602	A Family Member	=	71	533
606	59	>	18	537
608	81	<	18	539
610	Open	=	67	541
612	30	<	18	543
615	Open	=	13	545
616	Raining	=	17	546
621	Raining	!=	17	550
623	On	=	1	552
624	Closed	=	13	553
625	70	=	18	554
627	 	=	72	556
628	Closed	=	13	557
629	70	>	18	558
632	80	>	18	561
635	60	<	18	564
639	Raining	=	20	568
641	Home	!=	70	570
642	Anyone	 	71	570
644	Home	 	70	572
645	Anyone	=	71	572
647	67	<	18	574
649	67	<	18	576
653	On	=	1	580
656	Home	 	70	583
657	Anyone	 	71	583
659	On	=	1	585
661	On	=	1	587
663	On	=	1	589
667	Unlocked	=	12	593
668	Living Room	!=	70	594
669	A Family Member	 	71	594
670	No	=	25	595
675	{'text': "Smart Faucet's water turns On", 'parameters': [{'id': 72, 'type': 'bin', 'values': ['On', 'Off'], 'name': 'setting'}], 'capability': {'label': "{DEVICE}'s water turns {setting}", 'id': 64, 'name': 'Water On/Off'}, 'device': {'id': 22, 'name': 'Smart Faucet'}, 'channel': {'icon': 'local_drink', 'id': 17, 'name': 'Water & Plumbing'}, 'parameterVals': [{'comparator': '=', 'value': 'On'}]}	=	57	600
676	{'minutes': 0, 'seconds': 14, 'hours': 0}	>	58	600
679	Closed	=	13	603
680	Closed	=	13	604
685	Unlocked	=	12	609
686	Living Room	!=	70	610
687	A Family Member	 	71	610
688	No	=	25	611
690	On	=	1	613
691	23:00	>	23	614
693	Living Room	!=	70	616
694	A Family Member	 	71	616
695	 	=	25	617
698	Kitchen	!=	70	619
699	Bobbie	!=	71	619
701	On	=	1	621
703	On	=	1	623
706	On	=	1	626
719	80	>	18	637
722	Closed	=	13	640
723	Closed	=	13	641
725	60	<	18	643
727	Closed	=	13	645
728	Closed	=	13	646
730	Raining	=	20	648
732	40	<	75	650
734	Closed	=	13	652
735	Closed	=	13	653
738	On	=	1	656
741	On	=	1	658
742	Home	 	70	659
743	A Guest	=	71	659
744	Day	=	62	660
750	Day	=	62	665
751	On	=	1	666
758	Asleep	=	68	673
761	On	=	64	676
764	23:00	>	23	679
765	On	=	1	680
767	23:50	>	23	682
769	Kitchen	 	70	684
770	Bobbie	 	71	684
775	Home	 	70	688
776	A Family Member	 	71	688
778	Locked	=	12	690
780	Home	!=	70	692
781	Anyone	 	71	692
786	Home	!=	70	696
787	Anyone	=	71	696
788	75	>	18	697
790	23:45	>	23	699
792	On	=	64	701
796	23:45	>	23	705
798	Open	=	67	707
800	300	>	74	709
801	On	=	1	710
802	Home	 	70	711
803	A Guest	 	71	711
805	Home	 	70	713
806	A Guest	 	71	713
808	45	>	75	715
810	Open	=	67	717
811	Kitchen	 	70	718
812	Bobbie	 	71	718
819	Kitchen	 	70	724
820	Bobbie	 	71	724
821	Off	=	1	725
822	Asleep	=	68	726
824	Off	=	1	728
825	Asleep	=	68	729
828	Awake	=	68	732
830	Closed	=	13	734
831	Closed	=	13	735
832	Off	=	1	736
833	Asleep	=	68	737
835	Asleep	=	68	739
837	Asleep	=	68	741
842	Asleep	=	68	745
852	On	=	1	755
853	Pop	 	8	756
855	Home	=	70	758
856	Anyone	=	71	758
858	Home	=	70	760
859	Anyone	=	71	760
861	Home	 	70	762
862	Anyone	 	71	762
864	 	=	72	764
866	40	<	75	766
868	80	>	18	768
870	40	<	18	770
875	Open	=	67	774
880	80	>	18	779
882	Night	=	62	781
885	60	<	18	784
887	Raining	=	20	786
889	Open	=	13	788
904	Open	=	13	801
905	Clear	 	17	802
907	Clear	 	17	804
1065	On	=	1	931
1197	Closed	=	13	1053
912	{'text': 'Anyone is in Home', 'parameters': [{'id': 70, 'type': 'set', 'values': ['Home', 'Kitchen', 'Bedroom', 'Bathroom', 'Living Room'], 'name': 'location'}, {'id': 71, 'type': 'set', 'values': ['Anyone', 'Alice', 'Bobbie', 'A Family Member', 'A Guest'], 'name': 'who'}], 'capability': {'label': '{who/!=|Someone other than }{who} is {location/!=|not }in {location}', 'id': 63, 'name': 'Detect Presence'}, 'device': {'id': 12, 'name': 'Location Sensor'}, 'channel': {'icon': 'visibility', 'id': 6, 'name': 'Sensors'}, 'parameterVals': [{'comparator': '=', 'value': 'Home'}, {'comparator': '=', 'value': 'Anyone'}]}	=	57	809
913	{'minutes': 0, 'seconds': 1, 'hours': 0}	=	58	809
988	On	=	1	867
1216	Home	!=	70	1069
1217	A Guest	!=	71	1069
914	{'text': 'Anyone is in Home', 'parameters': [{'id': 70, 'type': 'set', 'values': ['Home', 'Kitchen', 'Bedroom', 'Bathroom', 'Living Room'], 'name': 'location'}, {'id': 71, 'type': 'set', 'values': ['Anyone', 'Alice', 'Bobbie', 'A Family Member', 'A Guest'], 'name': 'who'}], 'capability': {'label': '{who/!=|Someone other than }{who} is {location/!=|not }in {location}', 'id': 63, 'name': 'Detect Presence'}, 'device': {'id': 12, 'name': 'Location Sensor'}, 'channel': {'icon': 'room', 'id': 15, 'name': 'Location'}, 'parameterVals': [{'comparator': '=', 'value': 'Home'}, {'comparator': '=', 'value': 'Anyone'}]}	=	57	810
915	{'minutes': 0, 'seconds': 1, 'hours': 3}	>	58	810
917	23:59	<	23	812
918	Asleep	=	68	813
919	On	=	1	814
920	23:59	<	23	815
922	Closed	=	13	817
925	Closed	=	13	820
927	Closed	=	13	822
929	Closed	=	13	824
931	Closed	=	13	826
933	Closed	=	13	828
936	On	=	1	831
937	23:59	<	23	832
944	Kitchen	=	70	837
945	Anyone	 	71	837
948	{'text': "Smart Faucet's water turns On", 'parameters': [{'id': 72, 'type': 'bin', 'values': ['On', 'Off'], 'name': 'setting'}], 'capability': {'label': "{DEVICE}'s water turns {setting}", 'id': 64, 'name': 'Water On/Off'}, 'device': {'id': 22, 'name': 'Smart Faucet'}, 'channel': {'icon': 'local_drink', 'id': 17, 'name': 'Water & Plumbing'}, 'parameterVals': [{'comparator': '=', 'value': 'On'}]}	=	57	840
949	{'minutes': 0, 'seconds': 15, 'hours': 0}	>	58	840
957	Kitchen	!=	70	846
958	Bobbie	!=	71	846
964	On	=	1	851
965	Home	=	70	852
966	A Guest	 	71	852
967	{'text': 'A Guest is in Home', 'parameters': [{'id': 70, 'type': 'set', 'values': ['Home', 'Kitchen', 'Bedroom', 'Bathroom', 'Living Room'], 'name': 'location'}, {'id': 71, 'type': 'set', 'values': ['Anyone', 'Alice', 'Bobbie', 'A Family Member', 'A Guest'], 'name': 'who'}], 'capability': {'label': '{who/!=|Someone other than }{who} is {location/!=|not }in {location}', 'id': 63, 'name': 'Detect Presence'}, 'device': {'id': 12, 'name': 'Location Sensor'}, 'channel': {'icon': 'room', 'id': 15, 'name': 'Location'}, 'parameterVals': [{'comparator': ' ', 'value': 'Home'}, {'comparator': ' ', 'value': 'A Guest'}]}	=	57	853
968	{'minutes': 0, 'seconds': 0, 'hours': 3}	<	58	853
1188	Asleep	=	68	1045
1191	Kitchen	=	70	1048
1192	Bobbie	=	71	1048
982	Day	=	62	862
983	Night	=	62	863
985	{'text': "Smart Refrigerator's door Opens", 'parameters': [{'id': 67, 'type': 'bin', 'values': ['Open', 'Closed'], 'name': 'position'}], 'capability': {'label': "{DEVICE}'s door {position/T|Opens}{position/F|Closes}", 'id': 60, 'name': 'Open/Close Door'}, 'device': {'id': 8, 'name': 'Smart Refrigerator'}, 'channel': {'icon': 'fastfood', 'id': 13, 'name': 'Food & Cooking'}, 'parameterVals': [{'comparator': '=', 'value': 'Open'}]}	=	57	865
986	{'minutes': 2, 'seconds': 0, 'hours': 0}	>	58	865
989	{'text': 'Smart TV is On', 'parameters': [{'id': 1, 'type': 'bin', 'values': ['On', 'Off'], 'name': 'setting'}], 'capability': {'label': '{DEVICE} is {setting}', 'id': 2, 'name': 'Power On/Off'}, 'device': {'id': 5, 'name': 'Smart TV'}, 'channel': {'icon': 'tv', 'id': 12, 'name': 'Television'}, 'parameterVals': [{'comparator': '=', 'value': 'On'}]}	=	50	868
990	{'minutes': 30, 'seconds': 0, 'hours': 0}	=	51	868
999	On	=	1	876
1001	On	=	1	878
1235	Home	=	70	1084
1002	{'text': '(FitBit) I fall asleep', 'parameters': [{'id': 68, 'type': 'bin', 'values': ['Awake', 'Asleep'], 'name': 'status'}], 'capability': {'label': '({DEVICE}) I {status/T|wake up}{status/F|fall asleep}', 'id': 61, 'name': 'Sleep Sensor'}, 'device': {'id': 21, 'name': 'FitBit'}, 'channel': {'icon': 'favorite_border', 'id': 16, 'name': 'Health'}, 'parameterVals': [{'comparator': '=', 'value': 'Asleep'}]}	=	57	879
1003	{'minutes': 30, 'seconds': 0, 'hours': 0}	>	58	879
1005	{'text': 'Roomba turns Off', 'parameters': [{'id': 1, 'type': 'bin', 'values': ['On', 'Off'], 'name': 'setting'}], 'capability': {'label': '{DEVICE} turns {setting}', 'id': 2, 'name': 'Power On/Off'}, 'device': {'id': 1, 'name': 'Roomba'}, 'channel': {'icon': 'build', 'id': 18, 'name': 'Cleaning'}, 'parameterVals': [{'comparator': '=', 'value': 'Off'}]}	=	57	881
1006	{'minutes': 0, 'seconds': 0, 'hours': 3}	>	58	881
1013	Open	=	13	888
1015	Open	=	13	890
1018	Open	=	13	893
1019	80	<	18	894
1020	Closed	=	13	895
1022	Closed	=	13	897
1023	Not Raining	=	20	898
1024	60	>	18	899
1025	Not Raining	=	20	900
1027	Not Raining	=	20	902
1028	Closed	=	13	903
1032	{'text': "Smart Faucet's water turns On", 'parameters': [{'id': 72, 'type': 'bin', 'values': ['On', 'Off'], 'name': 'setting'}], 'capability': {'label': "{DEVICE}'s water turns {setting}", 'id': 64, 'name': 'Water On/Off'}, 'device': {'id': 22, 'name': 'Smart Faucet'}, 'channel': {'icon': 'local_drink', 'id': 17, 'name': 'Water & Plumbing'}, 'parameterVals': [{'comparator': '=', 'value': 'On'}]}	=	57	907
1033	{'minutes': 0, 'seconds': 15, 'hours': 0}	=	58	907
1036	On	=	1	909
1039	On	=	1	911
1045	On	=	1	916
1048	On	=	1	918
1050	{'text': "Smart Refrigerator's door Opens", 'parameters': [{'id': 67, 'type': 'bin', 'values': ['Open', 'Closed'], 'name': 'position'}], 'capability': {'label': "{DEVICE}'s door {position/T|Opens}{position/F|Closes}", 'id': 60, 'name': 'Open/Close Door'}, 'device': {'id': 8, 'name': 'Smart Refrigerator'}, 'channel': {'icon': 'fastfood', 'id': 13, 'name': 'Food & Cooking'}, 'parameterVals': [{'comparator': '=', 'value': 'Open'}]}	=	57	920
1051	{'minutes': 2, 'seconds': 0, 'hours': 0}	=	58	920
1054	Night	=	62	922
1056	Not Raining	=	20	924
1057	80	<	18	925
1059	{'text': "Smart Faucet's water turns On", 'parameters': [{'id': 72, 'type': 'bin', 'values': ['On', 'Off'], 'name': 'setting'}], 'capability': {'label': "{DEVICE}'s water turns {setting}", 'id': 64, 'name': 'Water On/Off'}, 'device': {'id': 22, 'name': 'Smart Faucet'}, 'channel': {'icon': 'local_drink', 'id': 17, 'name': 'Water & Plumbing'}, 'parameterVals': [{'comparator': '=', 'value': 'On'}]}	=	57	927
1060	{'minutes': 0, 'seconds': 15, 'hours': 0}	=	58	927
1064	Open	=	65	930
1068	Asleep	=	68	933
1070	 	=	72	935
1080	Off	=	72	945
1082	On	=	1	947
1212	Closed	=	13	1065
1213	Closed	=	13	1066
1091	Bathroom	=	70	955
1092	Anyone	=	71	955
1094	Closed	=	13	957
1095	Closed	=	13	958
1098	Home	=	70	961
1099	Anyone	=	71	961
1101	Closed	=	13	963
1102	60	>	18	964
1103	80	<	18	965
1104	Not Raining	=	20	966
1106	60	>	18	968
1107	80	<	18	969
1108	Not Raining	=	20	970
1113	Closed	=	13	975
1116	Closed	=	13	978
1118	Closed	=	13	980
1121	On	=	1	982
1123	Closed	=	13	984
1126	Open	=	13	987
1127	80	>	18	988
1129	On	=	1	990
1130	{'device': {'id': 21, 'name': 'FitBit'}, 'capability': {'id': 61, 'label': '({DEVICE}) I {status/T|Wake Up}{status/F|Fall Asleep}', 'name': 'Sleep Sensor'}, 'channel': {'id': 16, 'icon': 'favorite_border', 'name': 'Health'}, 'parameterVals': [{'value': 'Asleep', 'comparator': '='}], 'parameters': [{'id': 68, 'values': ['Awake', 'Asleep'], 'type': 'bin', 'name': 'status'}], 'text': '(FitBit) I Fall Asleep'}	=	57	991
1131	{'seconds': 0, 'minutes': 30, 'hours': 0}	>	58	991
1139	60	<	18	998
1140	Open	=	13	999
1141	60	<	18	1000
1143	60	<	18	1002
1145	60	<	18	1004
1147	80	>	18	1006
1151	Raining	=	20	1009
1153	Night	=	62	1011
1154	40	>	75	1012
1156	Pop	=	8	1014
1160	Night	=	62	1018
1162	Open	=	65	1020
1163	Open	=	65	1021
1169	Off	=	72	1026
1171	Open	=	65	1028
1172	Off	=	72	1029
1174	Locked	=	12	1031
1175	Motion	=	14	1032
1176	Locked	=	12	1033
1179	Open	=	67	1036
1180	Open	=	67	1037
1206	{'device': {'id': 8, 'name': 'Smart Refrigerator'}, 'capability': {'id': 60, 'label': "{DEVICE}'s door {position/T|Opens}{position/F|Closes}", 'name': 'Open/Close Door'}, 'channel': {'id': 13, 'icon': 'fastfood', 'name': 'Food & Cooking'}, 'parameterVals': [{'value': 'Open', 'comparator': '='}], 'parameters': [{'id': 67, 'values': ['Open', 'Closed'], 'type': 'bin', 'name': 'position'}], 'text': "Smart Refrigerator's door Opens"}	=	57	1061
1207	{'seconds': 0, 'minutes': 2, 'hours': 0}	>	58	1061
1222	On	=	1	1073
1223	Off	=	1	1074
1224	{'device': {'id': 21, 'name': 'FitBit'}, 'capability': {'id': 61, 'label': '({DEVICE}) I am {status}', 'name': 'Sleep Sensor'}, 'channel': {'id': 16, 'icon': 'favorite_border', 'name': 'Health'}, 'parameterVals': [{'value': 'Asleep', 'comparator': '='}], 'parameters': [{'id': 68, 'values': ['Awake', 'Asleep'], 'type': 'bin', 'name': 'status'}], 'text': '(FitBit) I am Asleep'}	=	57	1075
1225	{'seconds': 0, 'minutes': 30, 'hours': 0}	>	58	1075
1226	Closed	=	13	1076
1227	Closed	=	13	1077
1228	Closed	=	13	1078
1230	Open	=	65	1080
1233	On	=	1	1082
1236	A Guest	=	71	1084
1238	Closed	=	13	1086
1239	Closed	=	13	1087
1241	Off	=	1	1089
1242	Home	!=	70	1090
1243	A Guest	=	71	1090
1245	Open	=	65	1092
1247	Open	=	65	1094
1249	Home	=	70	1096
1250	A Family Member	=	71	1096
1254	Motion	=	14	1100
1255	Locked	=	12	1101
1257	On	=	1	1103
1260	Asleep	=	68	1106
1262	On	=	1	1108
1266	70	=	18	1112
1268	Asleep	=	68	1114
1271	80	>	18	1117
1274	Asleep	=	68	1120
1281	On	=	1	1127
1287	This 	=	35	1133
1289	80	>	18	1135
1290	Open	=	13	1136
1291	80	=	18	1137
1293	On	=	1	1139
1294	Asleep	=	68	1140
1295	On	=	1	1141
1297	Raining	=	20	1143
1298	Open	=	13	1144
1299	80	>	18	1145
1300	40	<	18	1146
1303	60	<	18	1149
1304	Open	=	13	1150
1305	60	<	18	1151
1308	Raining	=	20	1154
1311	Kitchen	=	70	1157
1312	Bobbie	=	71	1157
1314	60	<	18	1159
1316	80	>	18	1161
1321	Closed	=	65	1165
1332	Open	=	67	1173
1333		=	55	1174
1334	{'seconds': 0, 'minutes': 2, 'hours': 0}	=	56	1174
1336	75	=	21	1176
1337	Home	!=	70	1177
1338	Anyone	=	71	1177
1343	Home	!=	70	1181
1344	Anyone	=	71	1181
1351	70	=	21	1188
1352	Home	 	70	1189
1353	Anyone	 	71	1189
1356	Home	 	70	1192
1357	Anyone	 	71	1192
1361	Night	=	62	1196
1363	80	>	18	1198
1368	Asleep	=	68	1203
1370	Open	=	67	1205
1373	Off	=	1	1208
1375	Raining	=	20	1210
1377	48	>	18	1212
1378	Open	=	13	1213
1379	80	=	18	1214
1382	00:00	>	23	1217
1392	Off	=	1	1227
1394	80	<	18	1229
1395	60	>	18	1230
1396	Not Raining	=	20	1231
1398	Home	=	70	1233
1399	Anyone	=	71	1233
1409	On	=	1	1241
1422	Home	=	70	1251
1423	Anyone	=	71	1251
1424	Closed	=	13	1252
1425	Raining	=	20	1253
1427	Raining	=	20	1255
1428	Locked	=	12	1256
1429	80	>	18	1257
1431	60	<	18	1259
1434	80	>	18	1262
1436	Kitchen	=	70	1264
1437	Bobbie	 	71	1264
1440	Night	=	62	1267
1443	Night	=	62	1270
1445	Open	=	65	1272
1451	80	<	18	1278
1452	Not Raining	=	20	1279
1460	Home	!=	70	1287
1461	Anyone	 	71	1287
1463	On	=	1	1289
1466	On	=	1	1292
1468	12:00	>	23	1294
1469	Off	=	1	1295
1470	19:00	<	23	1296
1472	Open	=	67	1298
1474	20:00	>	23	1300
1476	Home	=	70	1302
1477	A Guest	 	71	1302
1478	Locked	=	12	1303
1479	Night	=	62	1304
1481	On	=	64	1306
1485	Home	!=	70	1310
1486	Anyone	 	71	1310
1488	80	>	74	1312
1491	 	=	72	1315
1493	Not Raining	=	20	1317
1496	70	<	18	1320
1497	Not Raining	=	20	1321
1500	Off	=	1	1324
1518	Asleep	=	68	1337
1521	On	=	64	1340
1523	80	>	18	1342
1525	Home	!=	70	1344
1526	Anyone	=	71	1344
1534	{'device': {'id': 22, 'name': 'Smart Faucet'}, 'capability': {'id': 64, 'label': "{DEVICE}'s water is {setting/F|not }running", 'name': 'Water On/Off'}, 'channel': {'id': 17, 'icon': 'local_drink', 'name': 'Water & Plumbing'}, 'parameterVals': [{'value': ' ', 'comparator': '='}], 'parameters': [{'id': 72, 'values': ['On', 'Off'], 'type': 'bin', 'name': 'setting'}], 'text': "Smart Faucet's water is running"}	=	50	1352
1535	{'seconds': 15, 'minutes': 0, 'hours': 0}	=	51	1352
1536	{'device': {'id': 22, 'name': 'Smart Faucet'}, 'capability': {'id': 64, 'label': "{DEVICE}'s water is {setting/F|not }running", 'name': 'Water On/Off'}, 'channel': {'id': 17, 'icon': 'local_drink', 'name': 'Water & Plumbing'}, 'parameterVals': [{'value': 'Off', 'comparator': '='}], 'parameters': [{'id': 72, 'values': ['On', 'Off'], 'type': 'bin', 'name': 'setting'}], 'text': "Smart Faucet's water is not running"}	=	55	1353
1537	{'seconds': 16, 'minutes': 0, 'hours': 0}	=	56	1353
1539	Raining	=	20	1355
1541	Night	=	62	1357
1544	 	=	72	1359
1551	80	<	18	1366
1552	60	>	21	1367
1555	On	=	1	1369
1562	Open	=	67	1376
1563	On	=	1	1377
1565	On	=	1	1379
1567	On	=	1	1381
1568	Bedroom	=	70	1382
1569	A Family Member	=	71	1382
1570	Night	=	62	1383
1573	Night	=	62	1385
1578	80	<	18	1390
1580	60	>	18	1392
1582	On	=	1	1394
1584	60	>	18	1396
1585	80	<	18	1397
1591	60	>	18	1401
1592	80	<	18	1402
1596	On	=	1	1405
1601	Off	=	64	1409
1602	Closed	=	13	1410
1603	Home	 	70	1411
1604	A Family Member	=	71	1411
1606	Home	 	70	1413
1607	A Family Member	=	71	1413
1608	Kitchen	=	70	1414
1609	Alice	!=	71	1414
1618	Closed	=	13	1421
1619	Closed	=	13	1422
1623	Closed	=	13	1425
1624	Closed	=	13	1426
1625	Closed	=	13	1427
1626	Closed	=	13	1428
1627	Closed	=	13	1429
1629	Closed	=	13	1431
1630	Closed	=	13	1432
1631	Closed	=	13	1433
1632	Closed	=	13	1434
1633	Closed	=	13	1435
1635	Closed	=	13	1437
1636	Closed	=	13	1438
1638	Closed	=	13	1440
1639	Closed	=	13	1441
1641	Closed	=	13	1443
1642	Closed	=	13	1444
1643	Off	=	1	1445
1644		>	24	1446
1647	75	>	18	1448
1649		>	24	1450
1654	70	<	18	1453
1702	{'seconds': 15, 'minutes': 0, 'hours': 0}	=	51	1485
1655	{'device': {'id': 22, 'name': 'Smart Faucet'}, 'capability': {'id': 64, 'label': "{DEVICE}'s water {setting/T|Turns On}{setting/F|Turns Off}", 'name': 'Water On/Off'}, 'channel': {'id': 17, 'icon': 'local_drink', 'name': 'Water & Plumbing'}, 'parameterVals': [{'value': 'On', 'comparator': '='}], 'parameters': [{'id': 72, 'values': ['On', 'Off'], 'type': 'bin', 'name': 'setting'}], 'text': "Smart Faucet's water Turns On"}	=	57	1454
1656	{'seconds': 15, 'minutes': 0, 'hours': 0}	=	58	1454
1667	{'device': {'id': 21, 'name': 'FitBit'}, 'capability': {'id': 61, 'label': '({DEVICE}) I {status/T|Wake Up}{status/F|Fall Asleep}', 'name': 'Sleep Sensor'}, 'channel': {'id': 6, 'icon': 'visibility', 'name': 'Sensors'}, 'parameterVals': [{'value': 'Asleep', 'comparator': '='}], 'parameters': [{'id': 68, 'values': ['Awake', 'Asleep'], 'type': 'bin', 'name': 'status'}], 'text': '(FitBit) I Fall Asleep'}	=	57	1463
1668	{'seconds': 0, 'minutes': 30, 'hours': 0}	=	58	1463
1669	79	>	18	1464
1678	{'device': {'id': 12, 'name': 'Location Sensor'}, 'capability': {'id': 63, 'label': '{who/=|}{who/!=|Someone other than }{who} {location/=|Enters}{location/!=|Exits} {location}', 'name': 'Detect Presence'}, 'channel': {'id': 15, 'icon': 'room', 'name': 'Location'}, 'parameterVals': [{'value': 'Home', 'comparator': '='}, {'value': 'A Guest', 'comparator': '='}], 'parameters': [{'id': 70, 'values': ['Home', 'Kitchen', 'Bedroom', 'Bathroom', 'Living Room'], 'type': 'set', 'name': 'location'}, {'id': 71, 'values': ['Anyone', 'Alice', 'Bobbie', 'A Family Member', 'A Guest'], 'type': 'set', 'name': 'who'}], 'text': 'A Guest Enters Home'}	=	57	1472
1679	{'seconds': 0, 'minutes': 0, 'hours': 3}	<	58	1472
1681	Home	 	70	1474
1682	Anyone	 	71	1474
1685	{'device': {'id': 12, 'name': 'Location Sensor'}, 'capability': {'id': 63, 'label': '{who/=|}{who/!=|Someone other than }{who} {location/=|Enters}{location/!=|Exits} {location}', 'name': 'Detect Presence'}, 'channel': {'id': 6, 'icon': 'visibility', 'name': 'Sensors'}, 'parameterVals': [{'value': 'Home', 'comparator': '='}, {'value': 'A Family Member', 'comparator': '!='}], 'parameters': [{'id': 70, 'values': ['Home', 'Kitchen', 'Bedroom', 'Bathroom', 'Living Room'], 'type': 'set', 'name': 'location'}, {'id': 71, 'values': ['Anyone', 'Alice', 'Bobbie', 'A Family Member', 'A Guest'], 'type': 'set', 'name': 'who'}], 'text': 'Someone other than A Family Member Enters Home'}	=	57	1476
1686	{'seconds': 0, 'minutes': 0, 'hours': 3}	=	58	1476
1690	Home	!=	70	1479
1691	A Family Member	!=	71	1479
1774	Asleep	=	68	1550
1777	On	=	1	1552
1779	Kitchen	 	70	1554
1780	Bobbie	 	71	1554
1878	{'capability': {'id': 64, 'name': 'Water On/Off', 'label': "{DEVICE}'s water {setting/T|Turns On}{setting/F|Turns Off}"}, 'device': {'id': 22, 'name': 'Smart Faucet'}, 'parameterVals': [{'comparator': '=', 'value': 'On'}], 'parameters': [{'id': 72, 'type': 'bin', 'values': ['On', 'Off'], 'name': 'setting'}], 'text': "Smart Faucet's water Turns On", 'channel': {'id': 17, 'icon': 'local_drink', 'name': 'Water & Plumbing'}}	=	57	1636
1879	{'minutes': 0, 'seconds': 15, 'hours': 0}	=	58	1636
1880	Open	=	13	1637
1694	{'device': {'id': 12, 'name': 'Location Sensor'}, 'capability': {'id': 63, 'label': '{who/=|}{who/!=|Someone other than }{who} {location/=|Enters}{location/!=|Exits} {location}', 'name': 'Detect Presence'}, 'channel': {'id': 6, 'icon': 'visibility', 'name': 'Sensors'}, 'parameterVals': [{'value': 'Home', 'comparator': '='}, {'value': 'A Family Member', 'comparator': '!='}], 'parameters': [{'id': 70, 'values': ['Home', 'Kitchen', 'Bedroom', 'Bathroom', 'Living Room'], 'type': 'set', 'name': 'location'}, {'id': 71, 'values': ['Anyone', 'Alice', 'Bobbie', 'A Family Member', 'A Guest'], 'type': 'set', 'name': 'who'}], 'text': 'Someone other than A Family Member Enters Home'}	=	57	1481
1695	{'seconds': 0, 'minutes': 0, 'hours': 3}	=	58	1481
1698	{'device': {'id': 12, 'name': 'Location Sensor'}, 'capability': {'id': 63, 'label': '{who/=|}{who/!=|Someone other than }{who} {location/=|Enters}{location/!=|Exits} {location}', 'name': 'Detect Presence'}, 'channel': {'id': 6, 'icon': 'visibility', 'name': 'Sensors'}, 'parameterVals': [{'value': 'Home', 'comparator': '!='}, {'value': 'A Family Member', 'comparator': '!='}], 'parameters': [{'id': 70, 'values': ['Home', 'Kitchen', 'Bedroom', 'Bathroom', 'Living Room'], 'type': 'set', 'name': 'location'}, {'id': 71, 'values': ['Anyone', 'Alice', 'Bobbie', 'A Family Member', 'A Guest'], 'type': 'set', 'name': 'who'}], 'text': 'Someone other than A Family Member Exits Home'}	=	57	1483
1699	{'seconds': 1, 'minutes': 0, 'hours': 0}	=	58	1483
1701	{'device': {'id': 22, 'name': 'Smart Faucet'}, 'capability': {'id': 64, 'label': "{DEVICE}'s water is {setting/F|not }running", 'name': 'Water On/Off'}, 'channel': {'id': 17, 'icon': 'local_drink', 'name': 'Water & Plumbing'}, 'parameterVals': [{'value': ' ', 'comparator': '='}], 'parameters': [{'id': 72, 'values': ['On', 'Off'], 'type': 'bin', 'name': 'setting'}], 'text': "Smart Faucet's water is running"}	=	50	1485
1894	{'capability': {'id': 60, 'name': 'Open/Close Door', 'label': "{DEVICE}'s door {position/T|Opens}{position/F|Closes}"}, 'device': {'id': 8, 'name': 'Smart Refrigerator'}, 'parameterVals': [{'comparator': '=', 'value': 'Open'}], 'parameters': [{'id': 67, 'type': 'bin', 'values': ['Open', 'Closed'], 'name': 'position'}], 'text': "Smart Refrigerator's door Opens", 'channel': {'id': 13, 'icon': 'fastfood', 'name': 'Food & Cooking'}}	=	57	1651
1909	Off	=	72	1662
1706	{'device': {'id': 12, 'name': 'Location Sensor'}, 'capability': {'id': 63, 'label': '{who/=|}{who/!=|Someone other than }{who} {location/=|Enters}{location/!=|Exits} {location}', 'name': 'Detect Presence'}, 'channel': {'id': 6, 'icon': 'visibility', 'name': 'Sensors'}, 'parameterVals': [{'value': 'Home', 'comparator': '!='}, {'value': 'A Family Member', 'comparator': '!='}], 'parameters': [{'id': 70, 'values': ['Home', 'Kitchen', 'Bedroom', 'Bathroom', 'Living Room'], 'type': 'set', 'name': 'location'}, {'id': 71, 'values': ['Anyone', 'Alice', 'Bobbie', 'A Family Member', 'A Guest'], 'type': 'set', 'name': 'who'}], 'text': 'Someone other than A Family Member Exits Home'}	=	57	1488
1707	{'seconds': 0, 'minutes': 0, 'hours': 3}	<	58	1488
1708	Locked	=	12	1489
1709	22:00	>	23	1490
1710	Locked	=	12	1491
1711	08:00	>	23	1492
1712	Unlocked	=	12	1493
1714	22:00	>	23	1495
1715	Locked	=	12	1496
1716	08:00	>	23	1497
1717	Unlocked	=	12	1498
1719	Day	=	62	1500
1720	Home	 	70	1501
1721	A Family Member	!=	71	1501
1722	On	=	1	1502
1727	Closed	=	13	1507
1728	Closed	=	13	1508
1730	Raining	 	17	1510
1732	80	>	18	1512
1734	60	<	18	1514
1746	60	>	18	1525
1747	80	<	18	1526
1748	Not Raining	=	20	1527
1750	Home	 	70	1529
1751	A Family Member	 	71	1529
1753	Closed	=	13	1531
1754	Closed	=	13	1532
1756	Home	 	70	1534
1757	A Family Member	 	71	1534
1761	Open	=	65	1538
1763	Asleep	=	68	1540
1765	Home	=	70	1542
1766	A Guest	=	71	1542
1768	Closed	=	13	1544
1769	Closed	=	13	1545
1771	Closed	=	13	1547
1772	Closed	=	13	1548
1786	On	=	72	1559
1788	60	>	18	1561
1789	Not Raining	=	20	1562
1791	60	>	18	1564
1792	Not Raining	=	20	1565
1794	80	<	18	1567
1795	Not Raining	=	20	1568
1797	60	>	18	1570
1798	80	<	18	1571
1804	On	=	1	1576
1806	Asleep	=	68	1578
1808	Unlocked	=	12	1580
1811	On	=	1	1582
1813	Home	 	70	1584
1814	A Guest	 	71	1584
1815	{'text': '(FitBit) I Fall Asleep', 'capability': {'id': 61, 'name': 'Sleep Sensor', 'label': '({DEVICE}) I {status/T|Wake Up}{status/F|Fall Asleep}'}, 'device': {'id': 21, 'name': 'FitBit'}, 'parameters': [{'id': 68, 'type': 'bin', 'values': ['Awake', 'Asleep'], 'name': 'status'}], 'parameterVals': [{'value': 'Asleep', 'comparator': '='}], 'channel': {'id': 16, 'icon': 'favorite_border', 'name': 'Health'}}	=	57	1585
1816	{'seconds': 0, 'hours': 0, 'minutes': 30}	=	58	1585
1817	{'text': '(FitBit) I Fall Asleep', 'capability': {'id': 61, 'name': 'Sleep Sensor', 'label': '({DEVICE}) I {status/T|Wake Up}{status/F|Fall Asleep}'}, 'device': {'id': 21, 'name': 'FitBit'}, 'parameters': [{'id': 68, 'type': 'bin', 'values': ['Awake', 'Asleep'], 'name': 'status'}], 'parameterVals': [{'value': 'Asleep', 'comparator': '='}], 'channel': {'id': 16, 'icon': 'favorite_border', 'name': 'Health'}}	=	57	1586
1818	{'seconds': 0, 'hours': 0, 'minutes': 30}	=	58	1586
1819	{'text': '(FitBit) I Fall Asleep', 'capability': {'id': 61, 'name': 'Sleep Sensor', 'label': '({DEVICE}) I {status/T|Wake Up}{status/F|Fall Asleep}'}, 'device': {'id': 21, 'name': 'FitBit'}, 'parameters': [{'id': 68, 'type': 'bin', 'values': ['Awake', 'Asleep'], 'name': 'status'}], 'parameterVals': [{'value': 'Asleep', 'comparator': '='}], 'channel': {'id': 16, 'icon': 'favorite_border', 'name': 'Health'}}	=	57	1587
1820	{'seconds': 0, 'hours': 0, 'minutes': 30}	=	58	1587
1821	On	=	26	1588
1822	Off	=	1	1589
1823	Raining	=	20	1590
1824	Raining	=	20	1591
1825	Open	=	13	1592
1829	On	=	64	1595
1830	80	=	21	1596
1832	80	=	21	1598
1834	Not Raining	=	20	1600
1835	Home	=	70	1601
1836	Anyone	=	71	1601
1840	Home	=	70	1604
1841	A Guest	=	71	1604
1842	17:00	>	23	1605
1843	20:00	<	23	1606
1845	Open	=	65	1608
1846	Home	=	70	1609
1847	A Guest	=	71	1609
1848	17:00	>	23	1610
1849	20:00	<	23	1611
1851	Open	=	65	1613
1852	Open	=	67	1614
1853	{'capability': {'id': 60, 'name': 'Open/Close Door', 'label': "{DEVICE}'s door is {position}"}, 'device': {'id': 8, 'name': 'Smart Refrigerator'}, 'parameterVals': [{'comparator': '=', 'value': 'Open'}], 'parameters': [{'id': 67, 'type': 'bin', 'values': ['Open', 'Closed'], 'name': 'position'}], 'text': "Smart Refrigerator's door is Open", 'channel': {'id': 13, 'icon': 'fastfood', 'name': 'Food & Cooking'}}	=	50	1615
1854	{'minutes': 2, 'seconds': 0, 'hours': 0}	=	51	1615
1857	17:00	>	23	1617
1858	20:00	<	23	1618
1860	Closed	=	13	1620
1861	Closed	=	13	1621
1863	Open	=	65	1623
1865	{'capability': {'id': 60, 'name': 'Open/Close Door', 'label': "{DEVICE}'s door is {position}"}, 'device': {'id': 8, 'name': 'Smart Refrigerator'}, 'parameterVals': [{'comparator': '=', 'value': 'Open'}], 'parameters': [{'id': 67, 'type': 'bin', 'values': ['Open', 'Closed'], 'name': 'position'}], 'text': "Smart Refrigerator's door is Open", 'channel': {'id': 13, 'icon': 'fastfood', 'name': 'Food & Cooking'}}	=	50	1625
1866	{'minutes': 2, 'seconds': 0, 'hours': 0}	=	51	1625
1872	40	=	75	1630
1881	80	=	18	1638
1885	80	=	18	1642
1889	Music	 	35	1646
1892	60	=	21	1649
1895	{'minutes': 2, 'seconds': 0, 'hours': 0}	>	58	1651
1898	Asleep	=	68	1654
1900	Asleep	=	68	1656
1901	Locked	=	12	1657
1902	Locked	=	12	1658
1910	Off	=	1	1663
1914	Open	=	13	1667
1915	60	<	18	1668
1916	Open	=	13	1669
1918	Closed	=	13	1671
1921	Kitchen	!=	70	1673
1922	Anyone	 	71	1673
1927	80	=	18	1677
1930	60	=	18	1680
1933	Open	=	67	1682
1939	30	=	7	1686
1943	59	>	18	1690
1944	81	<	18	1691
1945	Not Raining	=	20	1692
1949	{'capability': {'id': 64, 'name': 'Water On/Off', 'label': "{DEVICE}'s water {setting/T|Turns On}{setting/F|Turns Off}"}, 'device': {'id': 22, 'name': 'Smart Faucet'}, 'parameterVals': [{'comparator': '=', 'value': 'On'}], 'parameters': [{'id': 72, 'type': 'bin', 'values': ['On', 'Off'], 'name': 'setting'}], 'text': "Smart Faucet's water Turns On", 'channel': {'id': 17, 'icon': 'local_drink', 'name': 'Water & Plumbing'}}	=	57	1696
1950	{'minutes': 0, 'seconds': 15, 'hours': 0}	=	58	1696
1952	Kitchen	!=	70	1698
1953	Alice	!=	71	1698
1958	On	=	1	1702
1959	Home	!=	70	1703
1960	A Family Member	!=	71	1703
1969	Raining	=	20	1711
1971	81	<	18	1713
1972	Not Raining	=	20	1714
1974	Open	=	65	1716
1978	Kitchen	!=	70	1719
1979	Anyone	 	71	1719
1982	On	=	1	1722
1985	On	=	1	1725
1988	On	=	1	1728
1999	Kitchen	=	70	1738
2000	Bobbie	=	71	1738
2008	Closed	=	65	1745
2009	Closed	=	65	1746
2010	Closed	=	65	1747
2011	Closed	=	65	1748
2014	Not Raining	=	20	1751
2017	Off	=	64	1753
2023	Home	 	70	1758
2024	Anyone	!=	71	1758
2027	Not Raining	=	20	1761
2032	Kitchen	 	70	1765
2033	A Family Member	 	71	1765
2035	Home	=	70	1767
2036	Anyone	 	71	1767
2039	On	=	1	1770
2043	60	=	18	1774
2054	Home	=	70	1783
2055	Nobody	=	71	1783
2058	80	=	18	1786
2061	Open	=	67	1789
2063	Home	=	70	1791
2064	Anyone	=	71	1791
2070	81	<	18	1797
2074	Home	 	70	1800
2075	A Family Member	=	71	1800
2077	On	=	72	1802
2079	59	>	18	1804
2080	On	=	72	1805
2087	On	=	72	1811
2089	78	=	21	1813
2092	40	<	18	1815
2094	On	=	1	1817
2095	{'capability': {'id': 61, 'name': 'Sleep Sensor', 'label': '({DEVICE}) I am {status}'}, 'device': {'id': 21, 'name': 'FitBit'}, 'parameterVals': [{'comparator': '=', 'value': 'Asleep'}], 'parameters': [{'id': 68, 'type': 'bin', 'values': ['Awake', 'Asleep'], 'name': 'status'}], 'text': '(FitBit) I am Asleep', 'channel': {'id': 16, 'icon': 'favorite_border', 'name': 'Health'}}	=	55	1818
2096	{'minutes': 30, 'seconds': 0, 'hours': 0}	=	56	1818
2099	Motion	=	14	1821
2100	40	<	18	1822
2103	Home	=	70	1825
2104	Anyone	=	71	1825
2106	Asleep	=	68	1827
2111	On	=	64	1831
2114	Bedroom	 	70	1834
2115	Anyone	 	71	1834
2118	40	!=	18	1837
2125	Home	 	70	1843
2126	Nobody	!=	71	1843
2127	73	=	18	1844
2128	73	=	21	1845
2132	Home	!=	70	1849
2133	A Family Member	!=	71	1849
2134	Open	=	67	1850
2140	75	>	18	1855
2141	Home	=	70	1856
2142	Anyone	 	71	1856
2144	Asleep	=	68	1858
2147	Home	!=	70	1861
2148	Anyone	 	71	1861
2151	Home	=	70	1864
2152	Anyone	=	71	1864
2154	Home	 	70	1866
2155	Anyone	 	71	1866
2156	Home	 	70	1867
2157	Anyone	 	71	1867
2161	Open	=	65	1871
2169	Open	=	65	1877
2171	Pop	 	8	1879
2176	music	!=	35	1883
2178	Closed	=	13	1885
2179	Closed	=	13	1886
2181	On	=	1	1888
2182	Open	=	65	1889
2183	Home	!=	70	1890
2184	Anyone	=	71	1890
2189	Open	=	65	1895
2190	Open	=	65	1896
2191	Open	=	65	1897
2195	Closed	=	67	1901
2197	Home	 	70	1903
2198	Anyone	 	71	1903
2209	2	=	2	1910
2214	Kitchen	!=	70	1913
2215	Bobbie	!=	71	1913
2226	Open	=	13	1924
2228	Unlocked	=	12	1926
2230	Open	=	65	1928
2235	Kitchen	 	70	1932
2236	Bobbie	 	71	1932
2241	{'capability': {'id': 2, 'name': 'Power On/Off', 'label': '{DEVICE} is {setting}'}, 'device': {'id': 1, 'name': 'Roomba'}, 'parameterVals': [{'comparator': '=', 'value': 'Off'}], 'parameters': [{'id': 1, 'type': 'bin', 'values': ['On', 'Off'], 'name': 'setting'}], 'text': 'Roomba is Off', 'channel': {'id': 18, 'icon': 'build', 'name': 'Cleaning'}}	=	50	1937
2242	{'minutes': 0, 'seconds': 0, 'hours': 1}	=	51	1937
2243	{'capability': {'id': 64, 'name': 'Water On/Off', 'label': "{DEVICE}'s water is {setting/F|not }running"}, 'device': {'id': 22, 'name': 'Smart Faucet'}, 'parameterVals': [{'comparator': '=', 'value': ' '}], 'parameters': [{'id': 72, 'type': 'bin', 'values': ['On', 'Off'], 'name': 'setting'}], 'text': "Smart Faucet's water is running", 'channel': {'id': 13, 'icon': 'fastfood', 'name': 'Food & Cooking'}}	=	50	1938
2244	{'minutes': 1, 'seconds': 0, 'hours': 0}	=	51	1938
2251	Kitchen	 	70	1944
2252	Bobbie	 	71	1944
2258	Closed	=	65	1948
2259	Closed	=	13	1949
2260	Open	=	13	1950
2261	80	!=	18	1951
2263	On	=	72	1953
2272	Closed	=	65	1962
2274	60	<	18	1964
2275	80	>	18	1965
2280	80	>	18	1969
2281	60	<	18	1970
2285	60	<	18	1974
2287	Closed	=	13	1976
2289	Closed	=	65	1978
2295	80	>	18	1984
2296	60	<	18	1985
2305	On	=	1	1994
2307	Home	!=	70	1996
2308	Alice	=	71	1996
2309	On	=	72	1997
2310	Off	=	72	1998
2311	{'capability': {'id': 64, 'name': 'Water On/Off', 'label': "{DEVICE}'s water {setting/T|Turns On}{setting/F|Turns Off}"}, 'device': {'id': 22, 'name': 'Smart Faucet'}, 'parameterVals': [{'comparator': '=', 'value': 'On'}], 'parameters': [{'id': 72, 'type': 'bin', 'values': ['On', 'Off'], 'name': 'setting'}], 'text': "Smart Faucet's water Turns On", 'channel': {'id': 17, 'icon': 'local_drink', 'name': 'Water & Plumbing'}}	=	57	1999
2312	{'minutes': 0, 'seconds': 15, 'hours': 0}	=	58	1999
2314	Night	=	62	2001
2316	Off	=	72	2003
2317	{'capability': {'id': 64, 'name': 'Water On/Off', 'label': "{DEVICE}'s water {setting/T|Turns On}{setting/F|Turns Off}"}, 'device': {'id': 22, 'name': 'Smart Faucet'}, 'parameterVals': [{'comparator': '=', 'value': 'On'}], 'parameters': [{'id': 72, 'type': 'bin', 'values': ['On', 'Off'], 'name': 'setting'}], 'text': "Smart Faucet's water Turns On", 'channel': {'id': 17, 'icon': 'local_drink', 'name': 'Water & Plumbing'}}	=	57	2004
2318	{'minutes': 0, 'seconds': 15, 'hours': 0}	=	58	2004
2319	80	>	18	2005
2325	Closed	=	13	2010
2326	Closed	=	13	2011
2329	Closed	=	13	2014
2330	Closed	=	13	2015
2332	Asleep	=	68	2017
2336	Asleep	=	68	2019
2345	{'capability': {'id': 60, 'name': 'Open/Close Door', 'label': "{DEVICE}'s door {position/T|Opens}{position/F|Closes}"}, 'device': {'id': 8, 'name': 'Smart Refrigerator'}, 'parameterVals': [{'comparator': '=', 'value': 'Open'}], 'parameters': [{'id': 67, 'type': 'bin', 'values': ['Open', 'Closed'], 'name': 'position'}], 'text': "Smart Refrigerator's door Opens", 'channel': {'id': 13, 'icon': 'fastfood', 'name': 'Food & Cooking'}}	=	52	2027
2346	{'minutes': 2, 'seconds': 0, 'hours': 0}	=	53	2027
2347	1	>	54	2027
2348	Off	=	72	2028
2349	Off	=	72	2029
2350	Off	=	72	2030
2351	Off	=	72	2031
2354	Open	=	65	2033
2358	{'capability': {'id': 2, 'name': 'Power On/Off', 'label': '{DEVICE} is {setting}'}, 'device': {'id': 1, 'name': 'Roomba'}, 'parameterVals': [{'comparator': '=', 'value': 'Off'}], 'parameters': [{'id': 1, 'type': 'bin', 'values': ['On', 'Off'], 'name': 'setting'}], 'text': 'Roomba is Off', 'channel': {'id': 18, 'icon': 'build', 'name': 'Cleaning'}}	=	50	2036
2359	{'minutes': 0, 'seconds': 0, 'hours': 1}	=	51	2036
2361	On	=	1	2038
2363	Motion	=	14	2040
2365	On	=	1	2042
2367	23:00	=	23	2044
2372	No Motion	=	14	2049
2374	On	=	1	2051
2378	Night	=	62	2055
2381	Night	=	62	2058
2386	Open	=	67	2063
2388	Awake	=	68	2065
2397	Unlocked	=	12	2072
2402	Open	=	67	2077
2406	80	>	21	2081
2408	80	>	21	2083
2410	80	>	21	2085
2412	125	=	74	2087
2415	 	=	72	2089
2419	80	>	18	2093
2421	41	=	75	2095
2614	80	<	18	2258
2615	60	>	18	2259
2616	Not Raining	=	20	2260
2617	Closed	=	13	2261
2428	80	<	18	2101
2432	Closed	=	13	2104
2437	Closed	=	13	2108
2440	Closed	=	13	2111
2442	60	>	18	2113
2443	80	<	18	2114
2445	80	<	18	2116
2446	Off	=	1	2117
2447	21:00	=	23	2118
2451	Closed	=	13	2122
2453	21:00	=	23	2124
2455	Closed	=	13	2126
2458	Closed	=	13	2128
2459	Closed	=	13	2129
2460	Closed	=	13	2130
2462	Closed	=	13	2132
2465	59	>	18	2135
2466	81	<	18	2136
2467	Open	=	65	2137
2469	Closed	=	13	2139
2472	On	=	1	2142
2474	On	=	1	2144
2477	On	=	1	2147
2479	On	=	1	2149
2481	On	=	72	2151
2482	Kitchen	=	70	2152
2483	Bobbie	=	71	2152
2484	On	=	1	2153
2487	On	=	1	2155
2489	Clear	 	17	2157
2491	On	=	1	2159
2495	Clear	 	17	2162
2497	On	=	1	2164
2507	Pop	 	8	2171
2511	On	=	64	2174
2512	Closed	=	13	2175
2513	Closed	=	13	2176
2514	Closed	=	13	2177
2516	Kitchen	 	70	2179
2517	Alice	 	71	2179
2518	Closed	=	13	2180
2519	Closed	=	13	2181
2520	Closed	=	13	2182
2521	Closed	=	13	2183
2522	Closed	=	13	2184
2523	Closed	=	13	2185
2525	60	>	18	2187
2529	Closed	=	13	2190
2530	Closed	=	13	2191
2532	Closed	=	13	2193
2533	Closed	=	13	2194
2535	Closed	=	13	2196
2536	Closed	=	13	2197
2539	80	>	18	2200
2542	Home	=	70	2202
2543	Anyone	=	71	2202
2619	41	>	18	2263
2549	80	>	18	2206
2551	{'capability': {'id': 60, 'name': 'Open/Close Door', 'label': "{DEVICE}'s door {position/T|Opens}{position/F|Closes}"}, 'device': {'id': 8, 'name': 'Smart Refrigerator'}, 'parameterVals': [{'comparator': '=', 'value': 'Open'}], 'parameters': [{'id': 67, 'type': 'bin', 'values': ['Open', 'Closed'], 'name': 'position'}], 'text': "Smart Refrigerator's door Opens", 'channel': {'id': 13, 'icon': 'fastfood', 'name': 'Food & Cooking'}}	=	57	2208
2552	{'minutes': 2, 'seconds': 0, 'hours': 0}	=	58	2208
2553	Closed	=	13	2209
2554	60	<	18	2210
2555	Pop	=	8	2211
2558	59	<	18	2214
2561	40	<	75	2216
2562	Closed	=	67	2217
2563	Open	=	65	2218
2572	Closed	=	67	2225
2574	Closed	=	67	2227
2577	Home	 	70	2230
2578	A Guest	 	71	2230
2579	{'capability': {'id': 63, 'name': 'Detect Presence', 'label': '{who/=|}{who/!=|Someone other than }{who} {location/=|Enters}{location/!=|Exits} {location}'}, 'device': {'id': 12, 'name': 'Location Sensor'}, 'parameterVals': [{'comparator': '=', 'value': 'Home'}, {'comparator': '=', 'value': 'A Guest'}], 'parameters': [{'id': 70, 'type': 'set', 'values': ['Home', 'Kitchen', 'Bedroom', 'Bathroom', 'Living Room'], 'name': 'location'}, {'id': 71, 'type': 'set', 'values': ['Anyone', 'Alice', 'Bobbie', 'A Family Member', 'A Guest', 'Nobody'], 'name': 'who'}], 'text': 'A Guest Enters Home', 'channel': {'id': 6, 'icon': 'visibility', 'name': 'Sensors'}}	=	57	2231
2580	{'minutes': 0, 'seconds': 0, 'hours': 3}	<	58	2231
2582	Closed	=	67	2233
2585	Closed	=	13	2236
2588	70	<	18	2238
2589	75	>	18	2239
2591	Open	=	13	2241
2593	Open	=	13	2243
2595	On	=	1	2245
2596	No Motion	=	14	2246
2597	{'capability': {'id': 61, 'name': 'Sleep Sensor', 'label': '({DEVICE}) I {status/T|Wake Up}{status/F|Fall Asleep}'}, 'device': {'id': 21, 'name': 'FitBit'}, 'parameterVals': [{'comparator': '=', 'value': 'Asleep'}], 'parameters': [{'id': 68, 'type': 'bin', 'values': ['Awake', 'Asleep'], 'name': 'status'}], 'text': '(FitBit) I Fall Asleep', 'channel': {'id': 16, 'icon': 'favorite_border', 'name': 'Health'}}	=	57	2247
2598	{'minutes': 30, 'seconds': 0, 'hours': 0}	=	58	2247
2601	{'capability': {'id': 14, 'name': 'Open/Close Window', 'label': '{DEVICE} is {position}'}, 'device': {'id': 14, 'name': 'Bedroom Window'}, 'parameterVals': [{'comparator': '=', 'value': 'Closed'}], 'parameters': [{'id': 13, 'type': 'bin', 'values': ['Open', 'Closed'], 'name': 'position'}], 'text': 'Bedroom Window is Closed', 'channel': {'id': 5, 'icon': 'meeting_room', 'name': 'Windows & Doors'}}	=	55	2249
2602	{'minutes': 0, 'seconds': 0, 'hours': 0}	=	56	2249
2603	{'capability': {'id': 14, 'name': 'Open/Close Window', 'label': '{DEVICE} is {position}'}, 'device': {'id': 25, 'name': 'Living Room Window'}, 'parameterVals': [{'comparator': '=', 'value': 'Closed'}], 'parameters': [{'id': 13, 'type': 'bin', 'values': ['Open', 'Closed'], 'name': 'position'}], 'text': 'Living Room Window is Closed', 'channel': {'id': 5, 'icon': 'meeting_room', 'name': 'Windows & Doors'}}	=	55	2250
2604	{'minutes': 0, 'seconds': 0, 'hours': 0}	=	56	2250
2606	Open	=	13	2252
2610	Home	=	70	2256
2611	A Guest	=	71	2256
2622	Open	=	67	2265
2724	Home	!=	70	2355
2725	Nobody	 	71	2355
2623	{'capability': {'id': 60, 'name': 'Open/Close Door', 'label': "{DEVICE}'s door {position/T|Opens}{position/F|Closes}"}, 'device': {'id': 8, 'name': 'Smart Refrigerator'}, 'parameterVals': [{'comparator': '=', 'value': 'Open'}], 'parameters': [{'id': 67, 'type': 'bin', 'values': ['Open', 'Closed'], 'name': 'position'}], 'text': "Smart Refrigerator's door Opens", 'channel': {'id': 13, 'icon': 'fastfood', 'name': 'Food & Cooking'}}	=	52	2266
2624	{'minutes': 2, 'seconds': 0, 'hours': 0}	=	53	2266
2625	1	<	54	2266
2626	Pop	!=	8	2267
2638	{'capability': {'id': 60, 'name': 'Open/Close Door', 'label': "{DEVICE}'s door {position/T|Opens}{position/F|Closes}"}, 'device': {'id': 8, 'name': 'Smart Refrigerator'}, 'parameterVals': [{'comparator': '=', 'value': 'Open'}], 'parameters': [{'id': 67, 'type': 'bin', 'values': ['Open', 'Closed'], 'name': 'position'}], 'text': "Smart Refrigerator's door Opens", 'channel': {'id': 13, 'icon': 'fastfood', 'name': 'Food & Cooking'}}	=	57	2279
2639	{'minutes': 2, 'seconds': 0, 'hours': 0}	>	58	2279
2642	Open	=	65	2282
2655	{'text': '(FitBit) I Fall Asleep', 'parameters': [{'values': ['Awake', 'Asleep'], 'id': 68, 'name': 'status', 'type': 'bin'}], 'channel': {'icon': 'visibility', 'id': 6, 'name': 'Sensors'}, 'capability': {'id': 61, 'name': 'Sleep Sensor', 'label': '({DEVICE}) I {status/T|Wake Up}{status/F|Fall Asleep}'}, 'device': {'id': 21, 'name': 'FitBit'}, 'parameterVals': [{'comparator': '=', 'value': 'Asleep'}]}	=	57	2295
2656	{'minutes': 30, 'hours': 0, 'seconds': 0}	=	58	2295
2658	Asleep	=	68	2297
2660	Not Raining	=	20	2299
2661	59	>	18	2300
2662	81	<	18	2301
2664	Closed	=	13	2303
2666	{'text': "Smart Faucet's water is running", 'parameters': [{'values': ['On', 'Off'], 'id': 72, 'name': 'setting', 'type': 'bin'}], 'channel': {'icon': 'local_drink', 'id': 17, 'name': 'Water & Plumbing'}, 'capability': {'id': 64, 'name': 'Water On/Off', 'label': "{DEVICE}'s water is {setting/F|not }running"}, 'device': {'id': 22, 'name': 'Smart Faucet'}, 'parameterVals': [{'comparator': '=', 'value': ' '}]}	=	55	2305
2667	{'minutes': 15, 'hours': 0, 'seconds': 0}	=	56	2305
2671	Home	=	70	2309
2672	A Guest	=	71	2309
2676	Living Room	 	70	2313
2677	A Family Member	 	71	2313
2678	Night	=	62	2314
2679	On	=	1	2315
2688	{'parameters': [{'id': 67, 'name': 'position', 'type': 'bin', 'values': ['Open', 'Closed']}], 'parameterVals': [{'value': 'Closed', 'comparator': '='}], 'text': "Smart Refrigerator's door Closes", 'capability': {'id': 60, 'name': 'Open/Close Door', 'label': "{DEVICE}'s door {position/T|Opens}{position/F|Closes}"}, 'channel': {'icon': 'fastfood', 'id': 13, 'name': 'Food & Cooking'}, 'device': {'id': 8, 'name': 'Smart Refrigerator'}}	=	57	2324
2689	{'seconds': 0, 'hours': 0, 'minutes': 2}	>	58	2324
2697	On	=	1	2332
2707	On	=	1	2341
3258	On	=	72	2801
3260	On	=	72	2803
3262	On	=	72	2805
3264	On	=	72	2807
2708	{'parameters': [{'id': 68, 'name': 'status', 'type': 'bin', 'values': ['Awake', 'Asleep']}], 'parameterVals': [{'value': 'Asleep', 'comparator': '='}], 'text': '(FitBit) I Fall Asleep', 'capability': {'id': 61, 'name': 'Sleep Sensor', 'label': '({DEVICE}) I {status/T|Wake Up}{status/F|Fall Asleep}'}, 'channel': {'icon': 'visibility', 'id': 6, 'name': 'Sensors'}, 'device': {'id': 21, 'name': 'FitBit'}}	=	57	2342
2709	{'seconds': 0, 'hours': 0, 'minutes': 30}	=	58	2342
2712	Open	=	65	2345
2717	Home	!=	70	2349
2718	Anyone	!=	71	2349
2729	Home	 	70	2359
2730	Anyone	 	71	2359
2732	Closed	=	13	2361
2736	Home	 	70	2364
2737	Anyone	 	71	2364
2739	{'parameters': [{'id': 72, 'name': 'setting', 'type': 'bin', 'values': ['On', 'Off']}], 'parameterVals': [{'value': 'On', 'comparator': '='}], 'text': "Smart Faucet's water Turns On", 'capability': {'id': 64, 'name': 'Water On/Off', 'label': "{DEVICE}'s water {setting/T|Turns On}{setting/F|Turns Off}"}, 'channel': {'icon': 'local_drink', 'id': 17, 'name': 'Water & Plumbing'}, 'device': {'id': 22, 'name': 'Smart Faucet'}}	=	57	2366
2740	{'seconds': 15, 'hours': 0, 'minutes': 0}	>	58	2366
2743	On	=	1	2368
2744	Open	=	65	2369
2745	Open	=	13	2370
2751	Home	=	70	2375
2752	A Guest	 	71	2375
2756	{'parameters': [{'id': 72, 'name': 'setting', 'type': 'bin', 'values': ['On', 'Off']}], 'parameterVals': [{'value': 'On', 'comparator': '='}], 'text': "Smart Faucet's water Turns On", 'capability': {'id': 64, 'name': 'Water On/Off', 'label': "{DEVICE}'s water {setting/T|Turns On}{setting/F|Turns Off}"}, 'channel': {'icon': 'local_drink', 'id': 17, 'name': 'Water & Plumbing'}, 'device': {'id': 22, 'name': 'Smart Faucet'}}	=	52	2378
2757	{'seconds': 15, 'hours': 0, 'minutes': 0}	=	53	2378
2758	1	=	54	2378
2762	Unlocked	=	12	2382
2767	Open	=	67	2386
2771	{'parameters': [{'id': 67, 'name': 'position', 'type': 'bin', 'values': ['Open', 'Closed']}], 'parameterVals': [{'value': 'Open', 'comparator': '='}], 'text': "Smart Refrigerator's door is Open", 'capability': {'id': 60, 'name': 'Open/Close Door', 'label': "{DEVICE}'s door is {position}"}, 'channel': {'icon': 'fastfood', 'id': 13, 'name': 'Food & Cooking'}, 'device': {'id': 8, 'name': 'Smart Refrigerator'}}	=	55	2389
2772	{'seconds': 0, 'hours': 0, 'minutes': 2}	=	56	2389
2778	Open	=	65	2394
2779	Open	=	13	2395
2785	Home	=	70	2400
2786	A Guest	 	71	2400
2795	On	=	1	2407
2810	On	=	1	2417
2814	Asleep	=	68	2421
2817	{'parameters': [{'id': 72, 'name': 'setting', 'type': 'bin', 'values': ['On', 'Off']}], 'parameterVals': [{'value': 'On', 'comparator': '='}], 'text': "Smart Faucet's water Turns On", 'capability': {'id': 64, 'name': 'Water On/Off', 'label': "{DEVICE}'s water {setting/T|Turns On}{setting/F|Turns Off}"}, 'channel': {'icon': 'local_drink', 'id': 17, 'name': 'Water & Plumbing'}, 'device': {'id': 22, 'name': 'Smart Faucet'}}	=	57	2424
2818	{'seconds': 15, 'hours': 0, 'minutes': 0}	=	58	2424
2820	Asleep	=	68	2426
2826	Kitchen	=	70	2430
2827	Anyone	=	71	2430
2828	Open	=	67	2431
2831	Asleep	=	68	2434
2833	Open	=	13	2436
2834	On	=	1	2437
2835	On	=	1	2438
2837	Open	=	13	2440
2839	Closed	=	65	2442
2841	Asleep	=	68	2444
2844	Open	=	65	2447
2846	Closed	=	13	2449
2847	Closed	=	13	2450
2850	Open	=	65	2453
2852	Open	=	13	2455
2853	Off	=	1	2456
2854	Asleep	=	68	2457
2856	Open	=	65	2459
2858	Kitchen	=	70	2461
2859	Bobbie	=	71	2461
2862	Asleep	=	68	2464
2864	Bathroom	=	70	2466
2865	Anyone	=	71	2466
2867	Open	=	67	2468
2870	80	<	18	2471
2872	Awake	=	68	2473
2878	Pop	=	8	2478
2880	60	>	18	2480
2881	80	<	18	2481
2883	Home	!=	70	2483
2884	Anyone	=	71	2483
2889	On	=	72	2487
2891	Home	=	70	2489
2892	A Family Member	=	71	2489
2899	Bedroom	=	70	2494
2900	A Family Member	=	71	2494
2903	Kitchen	!=	70	2496
2904	Bobbie	!=	71	2496
2911	Closed	=	13	2501
2916	Closed	=	13	2505
2921	Kitchen	!=	70	2508
2922	Anyone	=	71	2508
2925	On	=	1	2510
2928	Closed	=	13	2513
2930	Closed	=	13	2515
2933	On	=	1	2517
2939	Closed	=	13	2523
2942	On	=	1	2526
2943	Open	=	65	2527
2944	Open	=	65	2528
2945	Open	=	65	2529
2947	Closed	=	13	2531
2949	Open	=	65	2533
2950	Open	=	65	2534
2951	Open	=	65	2535
2954	On	=	1	2538
2957	On	=	1	2541
2961	On	=	1	2545
2963	Off	=	64	2547
2966	On	=	1	2549
2971	On	=	1	2552
2975	80	=	18	2555
2980	Kitchen	!=	70	2560
2981	Anyone	=	71	2560
2983	80	>	18	2562
2984	Open	=	13	2563
2988	Open	=	13	2567
2991	Bedroom	=	70	2570
2992	Anyone	=	71	2570
2994	Open	=	13	2572
2996	Open	=	13	2574
2998	Open	=	13	2576
3006	On	=	1	2582
3266	Off	=	72	2809
3268	On	=	1	2811
3270	Kitchen	=	70	2813
3271	Bobbie	=	71	2813
3273	Kitchen	=	70	2815
3274	Bobbie	=	71	2815
3009	{'parameters': [{'id': 70, 'name': 'location', 'type': 'set', 'values': ['Home', 'Kitchen', 'Bedroom', 'Bathroom', 'Living Room']}, {'id': 71, 'name': 'who', 'type': 'set', 'values': ['Anyone', 'Alice', 'Bobbie', 'A Family Member', 'A Guest', 'Nobody']}], 'parameterVals': [{'value': 'Home', 'comparator': '='}, {'value': 'A Guest', 'comparator': '='}], 'text': 'A Guest Enters Home', 'capability': {'id': 63, 'name': 'Detect Presence', 'label': '{who/=|}{who/!=|Someone other than }{who} {location/=|Enters}{location/!=|Exits} {location}'}, 'channel': {'icon': 'room', 'id': 15, 'name': 'Location'}, 'device': {'id': 12, 'name': 'Location Sensor'}}	=	57	2584
3010	{'seconds': 0, 'hours': 3, 'minutes': 0}	<	58	2584
3108	Home	 	70	2667
3109	Anyone	=	71	2667
3111	Closed	=	13	2669
3244	On	=	72	2787
3016	On	=	1	2588
3019	On	=	1	2590
3026	Asleep	=	68	2595
3028	60	>	18	2597
3029	80	<	18	2598
3031	Closed	=	13	2600
3032	Closed	=	13	2601
3036	Closed	=	13	2605
3037	Closed	=	13	2606
3039	Closed	=	13	2608
3040	Closed	=	13	2609
3042	Closed	=	13	2611
3043	Closed	=	13	2612
3053	{'parameters': [{'id': 72, 'name': 'setting', 'type': 'bin', 'values': ['On', 'Off']}], 'parameterVals': [{'value': 'On', 'comparator': '='}], 'text': "Smart Faucet's water Turns On", 'capability': {'id': 64, 'name': 'Water On/Off', 'label': "{DEVICE}'s water {setting/T|Turns On}{setting/F|Turns Off}"}, 'channel': {'icon': 'local_drink', 'id': 17, 'name': 'Water & Plumbing'}, 'device': {'id': 22, 'name': 'Smart Faucet'}}	=	57	2620
3054	{'seconds': 15, 'hours': 0, 'minutes': 0}	>	58	2620
3055	 	=	72	2621
3058	On	=	1	2623
3061	Home	=	70	2626
3062	A Family Member	!=	71	2626
3066	Open	=	65	2630
3068	Open	=	65	2632
3070	Open	=	65	2634
3072	79	<	18	2636
3073	80	<	21	2637
3077	On	=	72	2641
3080	On	=	1	2643
3082	Open	=	67	2645
3083	{'parameters': [{'id': 67, 'name': 'position', 'type': 'bin', 'values': ['Open', 'Closed']}], 'parameterVals': [{'value': 'Open', 'comparator': '='}], 'text': "Smart Refrigerator's door is Open", 'capability': {'id': 60, 'name': 'Open/Close Door', 'label': "{DEVICE}'s door is {position}"}, 'channel': {'icon': 'fastfood', 'id': 13, 'name': 'Food & Cooking'}, 'device': {'id': 8, 'name': 'Smart Refrigerator'}}	=	50	2646
3084	{'seconds': 0, 'hours': 0, 'minutes': 2}	=	51	2646
3085	Open	=	67	2647
3088	Open	=	67	2649
3091	{'parameters': [{'id': 72, 'name': 'setting', 'type': 'bin', 'values': ['On', 'Off']}], 'parameterVals': [{'value': 'On', 'comparator': '='}], 'text': "Smart Faucet's water Turns On", 'capability': {'id': 64, 'name': 'Water On/Off', 'label': "{DEVICE}'s water {setting/T|Turns On}{setting/F|Turns Off}"}, 'channel': {'icon': 'local_drink', 'id': 17, 'name': 'Water & Plumbing'}, 'device': {'id': 22, 'name': 'Smart Faucet'}}	=	57	2651
3092	{'seconds': 15, 'hours': 0, 'minutes': 0}	=	58	2651
3103	Raining	=	20	2662
3104	60	<	18	2663
3105	80	>	18	2664
3112	Closed	=	13	2670
3117	80	>	18	2674
3118	Open	=	13	2675
3125	Open	=	13	2681
3126	80	=	18	2682
3127	Closed	=	13	2683
3128	60	=	18	2684
3130	{'parameters': [{'id': 70, 'name': 'location', 'type': 'set', 'values': ['Home', 'Kitchen', 'Bedroom', 'Bathroom', 'Living Room']}, {'id': 71, 'name': 'who', 'type': 'set', 'values': ['Anyone', 'Alice', 'Bobbie', 'A Family Member', 'A Guest', 'Nobody']}], 'parameterVals': [{'value': 'Home', 'comparator': '='}, {'value': 'A Family Member', 'comparator': '!='}], 'text': 'Someone other than A Family Member is in Home', 'capability': {'id': 63, 'name': 'Detect Presence', 'label': '{who/!=|Someone other than }{who} is {location/!=|not }in {location}'}, 'channel': {'icon': 'room', 'id': 15, 'name': 'Location'}, 'device': {'id': 12, 'name': 'Location Sensor'}}	=	57	2686
3131	{'seconds': 0, 'hours': 3, 'minutes': 0}	<	58	2686
3133	60	=	18	2688
3135	59	=	18	2690
3136	Closed	=	13	2691
3137	Raining	=	20	2692
3139	Raining	=	20	2694
3141	88	=	18	2696
3142	84	>	18	2697
3143	77	=	21	2698
3144	83	=	18	2699
3148	On	=	1	2702
3154	Pop	!=	8	2708
3157	Open	=	65	2711
3158	Open	=	65	2712
3169	Open	=	65	2722
3170	Open	=	65	2723
3178	Home	!=	70	2729
3179	Anyone	 	71	2729
3180	On	=	1	2730
3181	Home	=	70	2731
3182	A Guest	!=	71	2731
3187	Home	 	70	2735
3188	A Guest	!=	71	2735
3196	Night	=	62	2742
3197	Bedroom	 	70	2743
3198	Anyone	 	71	2743
3199	Asleep	=	68	2744
3201	Home	 	70	2746
3202	A Guest	 	71	2746
3203	17:00	>	23	2747
3205	Home	=	70	2749
3206	A Family Member	!=	71	2749
3209	Closed	=	13	2752
3210	Closed	=	13	2753
3212	Closed	=	13	2755
3213	Closed	=	13	2756
3215	Closed	=	13	2758
3216	Closed	=	13	2759
3224	On	=	72	2767
3226	On	=	72	2769
3228	On	=	72	2771
3230	On	=	72	2773
3232	On	=	72	2775
3234	On	=	72	2777
3236	On	=	72	2779
3238	On	=	72	2781
3240	On	=	72	2783
3242	On	=	72	2785
3246	On	=	72	2789
3248	On	=	72	2791
3250	On	=	72	2793
3252	On	=	72	2795
3254	On	=	72	2797
3256	On	=	72	2799
3276	Open	=	67	2817
3277	Closed	=	67	2818
3278	Closed	=	67	2819
3279	Closed	=	67	2820
3280	100	>	74	2821
3281	Closed	=	65	2822
3283	Off	=	72	2824
3284	Off	=	72	2825
3285	39	=	18	2826
3286	Asleep	=	68	2827
3287	Night	=	62	2828
3290	Closed	=	13	2831
3291	Closed	=	13	2832
3292	 	=	72	2833
3293	Closed	=	13	2834
3294	Closed	=	13	2835
3295	 	=	72	2836
3296	Closed	=	13	2837
3297	Closed	=	13	2838
3299	{'parameters': [{'id': 68, 'name': 'status', 'type': 'bin', 'values': ['Awake', 'Asleep']}], 'parameterVals': [{'value': 'Asleep', 'comparator': '='}], 'text': '(FitBit) I Fall Asleep', 'capability': {'id': 61, 'name': 'Sleep Sensor', 'label': '({DEVICE}) I {status/T|Wake Up}{status/F|Fall Asleep}'}, 'channel': {'icon': 'favorite_border', 'id': 16, 'name': 'Health'}, 'device': {'id': 21, 'name': 'FitBit'}}	=	57	2840
3300	{'seconds': 0, 'hours': 0, 'minutes': 30}	=	58	2840
3301	On	=	1	2841
3302	100	>	74	2842
3303	Closed	=	67	2843
3305	81	=	18	2845
3306	80	=	18	2846
3310	{'parameters': [{'id': 72, 'name': 'setting', 'type': 'bin', 'values': ['On', 'Off']}], 'parameterVals': [{'value': 'On', 'comparator': '='}], 'text': "Smart Faucet's water Turns On", 'capability': {'id': 64, 'name': 'Water On/Off', 'label': "{DEVICE}'s water {setting/T|Turns On}{setting/F|Turns Off}"}, 'channel': {'icon': 'fastfood', 'id': 13, 'name': 'Food & Cooking'}, 'device': {'id': 22, 'name': 'Smart Faucet'}}	=	57	2848
3311	{'seconds': 16, 'hours': 0, 'minutes': 0}	=	58	2848
3315	70	=	21	2851
3316	Home	 	70	2852
3317	Anyone	=	71	2852
3318	{'parameters': [{'id': 13, 'name': 'position', 'type': 'bin', 'values': ['Open', 'Closed']}], 'parameterVals': [{'value': 'Closed', 'comparator': '='}], 'text': 'Bathroom Window is Closed', 'capability': {'id': 14, 'name': 'Open/Close Window', 'label': '{DEVICE} is {position}'}, 'channel': {'icon': 'meeting_room', 'id': 5, 'name': 'Windows & Doors'}, 'device': {'id': 24, 'name': 'Bathroom Window'}}	=	50	2853
3319	{'seconds': 0, 'hours': 0, 'minutes': 0}	=	51	2853
3320	Closed	=	13	2854
3321	Closed	=	13	2855
3322	Closed	=	13	2856
3323	Closed	=	13	2857
3324	Closed	=	13	2858
3326	Closed	=	13	2860
3327	Closed	=	13	2861
3328	Closed	=	13	2862
3329	On	=	1	2863
3330	Kitchen	 	70	2864
3331	Alice	!=	71	2864
3332	Open	=	67	2865
3333	78	=	18	2866
3335	Closed	=	13	2868
3336	Closed	=	13	2869
3337	Closed	=	13	2870
3338	Closed	=	13	2871
3339	Closed	=	13	2872
3340	Closed	=	13	2873
3341	Open	=	65	2874
3342	Bedroom	 	70	2875
3343	Anyone	 	71	2875
3345	Open	=	13	2877
3346	Closed	=	13	2878
3347	80	>	18	2879
3471	Bobbie	=	71	2989
3472	Open	=	13	2990
3473	80	>	18	2991
3474	On	=	1	2992
3475	Asleep	=	68	2993
3572	A Family Member	!=	71	3074
3573	Home	 	70	3075
3574	Alice	!=	71	3075
3575	Home	 	70	3076
3576	Bobbie	!=	71	3076
3476	{'parameters': [{'id': 1, 'name': 'setting', 'type': 'bin', 'values': ['On', 'Off']}], 'parameterVals': [{'value': 'On', 'comparator': '='}], 'text': 'Smart TV turns On', 'capability': {'id': 2, 'name': 'Power On/Off', 'label': '{DEVICE} turns {setting}'}, 'channel': {'icon': 'tv', 'id': 12, 'name': 'Television'}, 'device': {'id': 5, 'name': 'Smart TV'}}	=	57	2994
3477	{'seconds': 0, 'hours': 0, 'minutes': 30}	=	58	2994
3348	{'parameters': [{'id': 70, 'name': 'location', 'type': 'set', 'values': ['Home', 'Kitchen', 'Bedroom', 'Bathroom', 'Living Room']}, {'id': 71, 'name': 'who', 'type': 'set', 'values': ['Anyone', 'Alice', 'Bobbie', 'A Family Member', 'A Guest', 'Nobody']}], 'parameterVals': [{'value': 'Home', 'comparator': '='}, {'value': 'Nobody', 'comparator': '!='}], 'text': 'Someone other than Nobody Enters Home', 'capability': {'id': 63, 'name': 'Detect Presence', 'label': '{who/=|}{who/!=|Someone other than }{who} {location/=|Enters}{location/!=|Exits} {location}'}, 'channel': {'icon': 'visibility', 'id': 6, 'name': 'Sensors'}, 'device': {'id': 12, 'name': 'Location Sensor'}}	=	57	2880
3349	{'seconds': 0, 'hours': 3, 'minutes': 0}	<	58	2880
3350	41	=	75	2881
3351	Open	=	67	2882
3352	Pop	=	8	2883
3353	Pop	=	8	2884
3354	Asleep	=	68	2885
3355	72	=	21	2886
3356	Locked	=	12	2887
3357	Night	=	62	2888
3358	Closed	=	67	2889
3359	Open	=	67	2890
3360	Closed	=	67	2891
3361	Open	=	67	2892
3362	Open	=	13	2893
3363	Raining	!=	17	2894
3364	Thunderstorms	=	17	2895
3365	Snowing	=	17	2896
3366	Hailing	=	17	2897
3367	Raining	=	20	2898
3368	Open	=	13	2899
3369	Sunny	 	17	2900
3370	Clear	 	17	2901
3371	Open	=	13	2902
3372	Raining	!=	17	2903
3373	Thunderstorms	=	17	2904
3374	Snowing	=	17	2905
3375	Hailing	=	17	2906
3376	Raining	=	20	2907
3377	40	<	75	2908
3379	Motion	=	14	2910
3380	Pop	=	8	2911
3381	81	=	18	2912
3382	Pop	=	8	2913
3383	60	<	21	2914
3384	80	>	18	2915
3385	Pop	=	8	2916
3386	Pop	=	8	2917
3387	Pop	=	8	2918
3388	Off	=	72	2919
3389	On	=	72	2920
3390	80	>	18	2921
3391	Raining	=	20	2922
3392	Asleep	=	68	2923
3393	Unlocked	=	12	2924
3394	On	=	1	2925
3395	Living Room	 	70	2926
3396	A Family Member	!=	71	2926
3397	Locked	=	12	2927
3398	Night	=	62	2928
3399	72	=	21	2929
3400	Home	=	70	2930
3401	A Family Member	=	71	2930
3402	On	=	72	2931
3404	Pop	=	8	2933
3405	Locked	=	12	2934
3406	Kitchen	=	70	2935
3407	Bobbie	=	71	2935
3408	On	=	72	2936
3409	{'parameters': [{'id': 72, 'name': 'setting', 'type': 'bin', 'values': ['On', 'Off']}], 'parameterVals': [{'value': ' ', 'comparator': '='}], 'text': "Smart Faucet's water is running", 'capability': {'id': 64, 'name': 'Water On/Off', 'label': "{DEVICE}'s water is {setting/F|not }running"}, 'channel': {'icon': 'local_drink', 'id': 17, 'name': 'Water & Plumbing'}, 'device': {'id': 22, 'name': 'Smart Faucet'}}	=	50	2937
3410	{'seconds': 15, 'hours': 0, 'minutes': 0}	=	51	2937
3411	Open	=	13	2938
3412	60	<	18	2939
3413	80	>	18	2940
3414	Raining	=	20	2941
3415	On	=	1	2942
3416	Living Room	 	70	2943
3417	A Family Member	!=	71	2943
3418	{'parameters': [{'id': 70, 'name': 'location', 'type': 'set', 'values': ['Home', 'Kitchen', 'Bedroom', 'Bathroom', 'Living Room']}, {'id': 71, 'name': 'who', 'type': 'set', 'values': ['Anyone', 'Alice', 'Bobbie', 'A Family Member', 'A Guest', 'Nobody']}], 'parameterVals': [{'value': 'Living Room', 'comparator': ' '}, {'value': 'A Family Member', 'comparator': '!='}], 'text': 'Someone other than A Family Member is in Living Room', 'capability': {'id': 63, 'name': 'Detect Presence', 'label': '{who/!=|Someone other than }{who} is {location/!=|not }in {location}'}, 'channel': {'icon': 'room', 'id': 15, 'name': 'Location'}, 'device': {'id': 12, 'name': 'Location Sensor'}}	=	57	2944
3419	{'seconds': 0, 'hours': 3, 'minutes': 0}	<	58	2944
3421	Living Room	 	70	2946
3422	A Family Member	!=	71	2946
3424	Open	=	65	2948
3425	On	=	1	2949
3426	Open	=	65	2950
3427	On	=	1	2951
3428	Open	=	65	2952
3429	On	=	1	2953
3430	Closed	=	65	2954
3431	On	=	1	2955
3432	Open	=	65	2956
3433	39	=	18	2957
3434	On	=	1	2958
3435	Open	=	65	2959
3436	41	=	18	2960
3437	On	=	1	2961
3438	Asleep	=	68	2962
3439	On	=	1	2963
3440	Kitchen	 	70	2964
3441	Bobbie	=	71	2964
3442	73	=	21	2965
3443	Home	 	70	2966
3444	Anyone	 	71	2966
3445	Kitchen	=	70	2967
3446	Bobbie	=	71	2967
3447	On	=	1	2968
3448	Open	=	13	2969
3449	60	>	18	2970
3450	Raining	!=	17	2971
3451	80	<	18	2972
3452	On	=	1	2973
3453	Open	=	65	2974
3454	Open	=	65	2975
3455	Open	=	65	2976
3456	Off	=	1	2977
3457	Asleep	=	68	2978
3458	Off	=	1	2979
3459	Asleep	=	68	2980
3460	Off	=	1	2981
3461	Asleep	=	68	2982
3462	Open	=	13	2983
3463	Raining	=	20	2984
3464	Asleep	=	68	2985
3465	On	=	1	2986
3466	Home	=	70	2987
3467	A Family Member	!=	71	2987
3468	Home	 	70	2988
3469	Alice	=	71	2988
3470	Home	=	70	2989
3478	Closed	=	65	2995
3479	On	=	1	2996
3480	Closed	=	65	2997
3481	Closed	=	65	2998
3482	Open	=	13	2999
3483	60	<	18	3000
3484	Home	=	70	3001
3485	A Family Member	!=	71	3001
3486	Home	 	70	3002
3487	Alice	=	71	3002
3488	Home	=	70	3003
3489	Bobbie	=	71	3003
3490	Open	=	65	3004
3491	Open	=	65	3005
3492	40	<	75	3006
3493	40	<	75	3007
3494	Home	=	70	3008
3495	A Family Member	!=	71	3008
3496	On	=	1	3009
3497	Open	=	65	3010
3498	On	=	1	3011
3499	Open	=	65	3012
3500	On	=	1	3013
3501	Open	=	65	3014
3502	On	=	1	3015
3503	Open	=	65	3016
3504	Pop	 	8	3017
3505	Raining	!=	17	3018
3506	60	>	18	3019
3507	80	<	18	3020
3509	On	=	72	3022
3511	Off	=	72	3024
3512	On	=	72	3025
3513	Kitchen	!=	70	3026
3514	Anyone	=	71	3026
3515	{'parameters': [{'id': 72, 'name': 'setting', 'type': 'bin', 'values': ['On', 'Off']}], 'parameterVals': [{'value': 'On', 'comparator': '='}], 'text': "Smart Faucet's water Turns On", 'capability': {'id': 64, 'name': 'Water On/Off', 'label': "{DEVICE}'s water {setting/T|Turns On}{setting/F|Turns Off}"}, 'channel': {'icon': 'local_drink', 'id': 17, 'name': 'Water & Plumbing'}, 'device': {'id': 22, 'name': 'Smart Faucet'}}	=	57	3027
3516	{'seconds': 15, 'hours': 0, 'minutes': 0}	=	58	3027
3614	{'seconds': 0, 'hours': 3, 'minutes': 0}	>	58	3105
3615	Closed	=	65	3106
3616	On	=	1	3107
3617	Night	=	62	3108
3618	22:00	=	23	3109
3619	Pop	!=	8	3110
3620	On	=	1	3111
3621	Open	=	65	3112
3517	{'parameters': [{'id': 72, 'name': 'setting', 'type': 'bin', 'values': ['On', 'Off']}], 'parameterVals': [{'value': ' ', 'comparator': '='}], 'text': "Smart Faucet's water is running", 'capability': {'id': 64, 'name': 'Water On/Off', 'label': "{DEVICE}'s water is {setting/F|not }running"}, 'channel': {'icon': 'local_drink', 'id': 17, 'name': 'Water & Plumbing'}, 'device': {'id': 22, 'name': 'Smart Faucet'}}	=	55	3028
3518	{'seconds': 0, 'hours': 0, 'minutes': 0}	=	56	3028
3519	{'parameters': [{'id': 72, 'name': 'setting', 'type': 'bin', 'values': ['On', 'Off']}], 'parameterVals': [{'value': 'On', 'comparator': '='}], 'text': "Smart Faucet's water Turns On", 'capability': {'id': 64, 'name': 'Water On/Off', 'label': "{DEVICE}'s water {setting/T|Turns On}{setting/F|Turns Off}"}, 'channel': {'icon': 'local_drink', 'id': 17, 'name': 'Water & Plumbing'}, 'device': {'id': 22, 'name': 'Smart Faucet'}}	=	57	3029
3520	{'seconds': 15, 'hours': 0, 'minutes': 0}	=	58	3029
3521	{'parameters': [{'id': 72, 'name': 'setting', 'type': 'bin', 'values': ['On', 'Off']}], 'parameterVals': [{'value': ' ', 'comparator': '='}], 'text': "Smart Faucet's water is running", 'capability': {'id': 64, 'name': 'Water On/Off', 'label': "{DEVICE}'s water is {setting/F|not }running"}, 'channel': {'icon': 'local_drink', 'id': 17, 'name': 'Water & Plumbing'}, 'device': {'id': 22, 'name': 'Smart Faucet'}}	=	55	3030
3522	{'seconds': 1, 'hours': 0, 'minutes': 0}	=	56	3030
3523	Locked	=	12	3031
3524	Night	=	62	3032
3525	100	=	74	3033
3526	Kitchen	 	70	3034
3527	Alice	!=	71	3034
3528	Open	=	65	3035
3529	On	=	1	3036
3530	Home	=	70	3037
3531	A Family Member	!=	71	3037
3533	Off	=	72	3039
3534	{'parameters': [{'id': 67, 'name': 'position', 'type': 'bin', 'values': ['Open', 'Closed']}], 'parameterVals': [{'value': 'Open', 'comparator': '='}], 'text': "Smart Refrigerator's door Opens", 'capability': {'id': 60, 'name': 'Open/Close Door', 'label': "{DEVICE}'s door {position/T|Opens}{position/F|Closes}"}, 'channel': {'icon': 'fastfood', 'id': 13, 'name': 'Food & Cooking'}, 'device': {'id': 8, 'name': 'Smart Refrigerator'}}	=	57	3040
3535	{'seconds': 0, 'hours': 0, 'minutes': 2}	=	58	3040
3536	{'parameters': [{'id': 67, 'name': 'position', 'type': 'bin', 'values': ['Open', 'Closed']}], 'parameterVals': [{'value': 'Open', 'comparator': '='}], 'text': "Smart Refrigerator's door is Open", 'capability': {'id': 60, 'name': 'Open/Close Door', 'label': "{DEVICE}'s door is {position}"}, 'channel': {'icon': 'fastfood', 'id': 13, 'name': 'Food & Cooking'}, 'device': {'id': 8, 'name': 'Smart Refrigerator'}}	=	55	3041
3537	{'seconds': 1, 'hours': 0, 'minutes': 0}	=	56	3041
3538	Open	=	65	3042
3540	On	=	1	3044
3541	Asleep	=	68	3045
3542	Pop	=	8	3046
3543	{'parameters': [{'id': 68, 'name': 'status', 'type': 'bin', 'values': ['Awake', 'Asleep']}], 'parameterVals': [{'value': 'Asleep', 'comparator': '='}], 'text': '(FitBit) I am Asleep', 'capability': {'id': 61, 'name': 'Sleep Sensor', 'label': '({DEVICE}) I am {status}'}, 'channel': {'icon': 'visibility', 'id': 6, 'name': 'Sensors'}, 'device': {'id': 21, 'name': 'FitBit'}}	=	55	3047
3544	{'seconds': 0, 'hours': 0, 'minutes': 30}	=	56	3047
3549	Open	=	13	3052
3550	Closed	=	13	3053
3551	Closed	=	13	3054
3552	Locked	=	12	3055
3553	Closed	=	67	3056
3557	40	=	18	3060
3558	Open	=	13	3061
3559	Raining	=	20	3062
3560	60	=	18	3063
3561	80	=	18	3064
3562	Off	=	1	3065
3563	23:00	>	23	3066
3564	Off	=	1	3067
3565	Night	=	62	3068
3566	Open	=	67	3069
3567	On	=	1	3070
3568	17:00	>	23	3071
3570	Motion	=	14	3073
3571	Home	 	70	3074
3577	Open	=	67	3077
3578	{'parameters': [{'id': 67, 'name': 'position', 'type': 'bin', 'values': ['Open', 'Closed']}], 'parameterVals': [{'value': 'Open', 'comparator': '='}], 'text': "Smart Refrigerator's door Opens", 'capability': {'id': 60, 'name': 'Open/Close Door', 'label': "{DEVICE}'s door {position/T|Opens}{position/F|Closes}"}, 'channel': {'icon': 'fastfood', 'id': 13, 'name': 'Food & Cooking'}, 'device': {'id': 8, 'name': 'Smart Refrigerator'}}	=	57	3078
3579	{'seconds': 0, 'hours': 0, 'minutes': 2}	>	58	3078
3580	No	=	25	3079
3581	Night	=	62	3080
3582	Off	=	1	3081
3583	23:00	=	23	3082
3585	17:00	=	23	3084
3586	On	=	72	3085
3587	{'parameters': [{'id': 72, 'name': 'setting', 'type': 'bin', 'values': ['On', 'Off']}], 'parameterVals': [{'value': 'On', 'comparator': '='}], 'text': "Smart Faucet's water Turns On", 'capability': {'id': 64, 'name': 'Water On/Off', 'label': "{DEVICE}'s water {setting/T|Turns On}{setting/F|Turns Off}"}, 'channel': {'icon': 'local_drink', 'id': 17, 'name': 'Water & Plumbing'}, 'device': {'id': 22, 'name': 'Smart Faucet'}}	=	57	3086
3588	{'seconds': 15, 'hours': 0, 'minutes': 0}	>	58	3086
3589	Off	=	1	3087
3590	17:00	=	23	3088
3595	Pop	=	8	3092
3598	Home	!=	70	3094
3599	Anyone	=	71	3094
3600	Off	=	64	3095
3601	Home	!=	70	3096
3602	A Family Member	=	71	3096
3603	Off	=	1	3097
3604	17:00	=	23	3098
3605	Off	=	72	3099
3606	On	=	72	3100
3607	Open	=	13	3101
3608	Locked	=	12	3102
3609	Kitchen	=	70	3103
3610	Bobbie	 	71	3103
3611	Home	=	70	3104
3612	Alice	!=	71	3104
3613	{'parameters': [{'id': 70, 'name': 'location', 'type': 'set', 'values': ['Home', 'Kitchen', 'Bedroom', 'Bathroom', 'Living Room']}, {'id': 71, 'name': 'who', 'type': 'set', 'values': ['Anyone', 'Alice', 'Bobbie', 'A Family Member', 'A Guest', 'Nobody']}], 'parameterVals': [{'value': 'Home', 'comparator': '='}, {'value': 'Anyone', 'comparator': '!='}], 'text': 'Someone other than Anyone Enters Home', 'capability': {'id': 63, 'name': 'Detect Presence', 'label': '{who/=|}{who/!=|Someone other than }{who} {location/=|Enters}{location/!=|Exits} {location}'}, 'channel': {'icon': 'visibility', 'id': 6, 'name': 'Sensors'}, 'device': {'id': 12, 'name': 'Location Sensor'}}	=	57	3105
3622	Day	=	62	3113
3623	Locked	=	12	3114
3624	Not Raining	=	20	3115
3625	Bedroom	=	70	3116
3626	Anyone	=	71	3116
3628	Pop	=	8	3118
3629	Day	=	62	3119
3630	Home	!=	70	3120
3631	Anyone	 	71	3120
3632	Not Raining	=	20	3121
3633	Bedroom	!=	70	3122
3634	A Family Member	=	71	3122
3635	Locked	=	12	3123
3636	Pop	=	8	3124
3637	80	>	18	3125
3638	Closed	=	13	3126
3639	Night	=	62	3127
3640	On	=	1	3128
3641	Open	=	65	3129
3642	Open	=	65	3130
3643	Open	=	65	3131
3645	{'parameters': [{'id': 72, 'name': 'setting', 'type': 'bin', 'values': ['On', 'Off']}], 'parameterVals': [{'value': 'On', 'comparator': '='}], 'text': "Smart Faucet's water Turns On", 'capability': {'id': 64, 'name': 'Water On/Off', 'label': "{DEVICE}'s water {setting/T|Turns On}{setting/F|Turns Off}"}, 'channel': {'icon': 'local_drink', 'id': 17, 'name': 'Water & Plumbing'}, 'device': {'id': 22, 'name': 'Smart Faucet'}}	=	57	3133
3646	{'seconds': 15, 'hours': 0, 'minutes': 0}	=	58	3133
3647	Off	=	1	3134
3648	Night	=	62	3135
3652	Unlocked	=	12	3138
3653	Off	=	1	3139
3654	Night	=	62	3140
3655	On	=	1	3141
3656	Home	=	70	3142
3657	A Guest	 	71	3142
3658	Day	=	62	3143
3659	Home	 	70	3144
3660	Anyone	 	71	3144
3661	Unlocked	=	12	3145
3662	Closed	=	13	3146
3663	Off	=	1	3147
3664	Asleep	=	68	3148
3665	Locked	=	12	3149
3666	Asleep	=	68	3150
3667	On	=	1	3151
3668	Asleep	=	68	3152
3669	Off	=	64	3153
3670	79	>	18	3154
3671	Day	=	62	3155
3672	Home	!=	70	3156
3673	Anyone	 	71	3156
3674	Locked	=	12	3157
3675	Closed	=	13	3158
3676	Closed	=	13	3159
3677	Closed	=	13	3160
3678	40	!=	75	3161
3679	Unlocked	=	12	3162
3680	Home	!=	70	3163
3681	Anyone	 	71	3163
3682	Locked	=	12	3164
3683	Asleep	=	68	3165
3684	80	=	18	3166
3685	Off	=	1	3167
3686	Asleep	=	68	3168
3687	Closed	=	13	3169
3688	Closed	=	13	3170
3689	Closed	=	13	3171
3690	Home	=	70	3172
3691	Anyone	=	71	3172
3692	Day	=	62	3173
3693	Unlocked	=	12	3174
3694	Closed	=	13	3175
3695	Closed	=	13	3176
3696	Closed	=	13	3177
3698	75	>	18	3179
3699	Home	 	70	3180
3700	Nobody	!=	71	3180
3701	75	>	18	3181
3702	Home	 	70	3182
3703	Nobody	!=	71	3182
3704	75	>	18	3183
3705	Home	 	70	3184
3706	Nobody	!=	71	3184
3707	On	=	1	3185
3708	Open	=	65	3186
3710	{'parameters': [{'id': 72, 'name': 'setting', 'type': 'bin', 'values': ['On', 'Off']}], 'parameterVals': [{'value': 'On', 'comparator': '='}], 'text': "Smart Faucet's water Turns On", 'capability': {'id': 64, 'name': 'Water On/Off', 'label': "{DEVICE}'s water {setting/T|Turns On}{setting/F|Turns Off}"}, 'channel': {'icon': 'local_drink', 'id': 17, 'name': 'Water & Plumbing'}, 'device': {'id': 22, 'name': 'Smart Faucet'}}	=	57	3188
3711	{'seconds': 0, 'hours': 0, 'minutes': 15}	=	58	3188
3713	80	>	18	3190
3717	Motion	=	14	3193
3718	Asleep	=	68	3194
3719	Motion	=	14	3195
3720	Asleep	=	68	3196
3722	Off	=	64	3198
3723	80	=	18	3199
3724	On	=	1	3200
3725	Awake	=	68	3201
3726	75	<	69	3202
3727	On	=	1	3203
3728	Home	=	70	3204
3729	Anyone	=	71	3204
3730	On	=	1	3205
3731	Home	 	70	3206
3732	A Guest	 	71	3206
3733	Pop	=	8	3207
3734	Off	=	64	3208
3735	80	=	18	3209
3736	Open	=	67	3210
3737	Pop	=	8	3211
3738	On	=	1	3212
3739	Home	=	70	3213
3740	Anyone	=	71	3213
3741	Open	=	65	3214
3742	Pop	!=	8	3215
3743	Home	=	70	3216
3744	Anyone	=	71	3216
3745	{'parameters': [{'id': 72, 'name': 'setting', 'type': 'bin', 'values': ['On', 'Off']}], 'parameterVals': [{'value': 'On', 'comparator': '='}], 'text': "Smart Faucet's water Turns On", 'capability': {'id': 64, 'name': 'Water On/Off', 'label': "{DEVICE}'s water {setting/T|Turns On}{setting/F|Turns Off}"}, 'channel': {'icon': 'local_drink', 'id': 17, 'name': 'Water & Plumbing'}, 'device': {'id': 22, 'name': 'Smart Faucet'}}	=	57	3217
3746	{'seconds': 15, 'hours': 0, 'minutes': 0}	>	58	3217
3747	 	=	72	3218
3748	On	=	72	3219
3749	{'parameters': [{'id': 72, 'name': 'setting', 'type': 'bin', 'values': ['On', 'Off']}], 'parameterVals': [{'value': 'On', 'comparator': '='}], 'text': "Smart Faucet's water Turns On", 'capability': {'id': 64, 'name': 'Water On/Off', 'label': "{DEVICE}'s water {setting/T|Turns On}{setting/F|Turns Off}"}, 'channel': {'icon': 'local_drink', 'id': 17, 'name': 'Water & Plumbing'}, 'device': {'id': 22, 'name': 'Smart Faucet'}}	=	52	3220
3750	{'seconds': 15, 'hours': 0, 'minutes': 0}	=	53	3220
3751	1	=	54	3220
3754	Open	=	13	3223
3755	60	<	18	3224
3756	Kitchen	=	70	3225
3757	Bobbie	=	71	3225
3758	Pop	=	8	3226
3759	Open	=	65	3227
3760	On	=	1	3228
3761	Home	!=	70	3229
3762	Anyone	=	71	3229
3763	75	>	21	3230
3764	Off	=	1	3231
3765	Asleep	=	68	3232
3766	Home	!=	70	3233
3767	Anyone	=	71	3233
3769	Open	=	13	3235
3770	Closed	=	13	3236
3771	Closed	=	13	3237
3773	On	=	1	3239
3774	 	=	72	3240
3775	{'parameters': [{'id': 72, 'name': 'setting', 'type': 'bin', 'values': ['On', 'Off']}], 'parameterVals': [{'value': ' ', 'comparator': '='}], 'text': "Smart Faucet's water is running", 'capability': {'id': 64, 'name': 'Water On/Off', 'label': "{DEVICE}'s water is {setting/F|not }running"}, 'channel': {'icon': 'local_drink', 'id': 17, 'name': 'Water & Plumbing'}, 'device': {'id': 22, 'name': 'Smart Faucet'}}	=	57	3241
3776	{'seconds': 15, 'hours': 0, 'minutes': 0}	=	58	3241
3778	Asleep	=	68	3243
3779	Open	=	65	3244
3780	On	=	1	3245
3781	Closed	=	67	3246
3782	Open	=	65	3247
3783	40	<	18	3248
3784	Open	=	13	3249
3785	Closed	=	13	3250
3786	Closed	=	13	3251
3787	Open	=	65	3252
3788	Kitchen	=	70	3253
3789	Bobbie	=	71	3253
3790	Kitchen	 	70	3254
3791	Nobody	 	71	3254
3792	Closed	=	67	3255
3793	Home	 	70	3256
3794	Anyone	=	71	3256
3795	73	=	21	3257
3796	Home	=	70	3258
3797	A Guest	=	71	3258
3798	{'parameters': [{'id': 70, 'name': 'location', 'type': 'set', 'values': ['Home', 'Kitchen', 'Bedroom', 'Bathroom', 'Living Room']}, {'id': 71, 'name': 'who', 'type': 'set', 'values': ['Anyone', 'Alice', 'Bobbie', 'A Family Member', 'A Guest', 'Nobody']}], 'parameterVals': [{'value': 'Home', 'comparator': '='}, {'value': 'A Guest', 'comparator': '='}], 'text': 'A Guest Enters Home', 'capability': {'id': 63, 'name': 'Detect Presence', 'label': '{who/=|}{who/!=|Someone other than }{who} {location/=|Enters}{location/!=|Exits} {location}'}, 'channel': {'icon': 'visibility', 'id': 6, 'name': 'Sensors'}, 'device': {'id': 12, 'name': 'Location Sensor'}}	=	57	3259
3799	{'seconds': 0, 'hours': 3, 'minutes': 0}	>	58	3259
3800	80	>	18	3260
3801	Open	=	13	3261
3802	Closed	=	13	3262
3803	Closed	=	13	3263
3804	Kitchen	=	70	3264
3805	Bobbie	=	71	3264
3806	Kitchen	 	70	3265
3807	Nobody	 	71	3265
3808	Open	=	67	3266
3809	Locked	=	12	3267
3810	Asleep	=	68	3268
3811	Unlocked	=	12	3269
3812	Asleep	=	68	3270
3814	Unlocked	=	12	3272
3816	Locked	=	12	3274
3817	Motion	=	14	3275
3819	Open	=	67	3277
3821	Bedroom	=	70	3279
3822	A Family Member	=	71	3279
3823	Closed	=	13	3280
3824	Closed	=	13	3281
3825	Pop	=	8	3282
3826	pop	 	35	3283
3827	Home	=	70	3284
3828	Anyone	=	71	3284
3829	On	=	1	3285
3830	Asleep	=	68	3286
3831	Open	=	67	3287
3832	Locked	=	12	3288
3833	Bedroom	=	70	3289
3834	Nobody	!=	71	3289
3835	Open	=	67	3290
3836	 	=	25	3291
3837	40	<	18	3292
3838	45	>	18	3293
3840	Kitchen	 	70	3295
3841	Anyone	 	71	3295
3844	Pop	!=	8	3297
3846	Off	=	1	3299
3847	Asleep	=	68	3300
3848	{'parameters': [{'id': 72, 'name': 'setting', 'type': 'bin', 'values': ['On', 'Off']}], 'parameterVals': [{'value': 'On', 'comparator': '='}], 'text': "Smart Faucet's water Turns On", 'capability': {'id': 64, 'name': 'Water On/Off', 'label': "{DEVICE}'s water {setting/T|Turns On}{setting/F|Turns Off}"}, 'channel': {'icon': 'local_drink', 'id': 17, 'name': 'Water & Plumbing'}, 'device': {'id': 22, 'name': 'Smart Faucet'}}	=	57	3301
3849	{'seconds': 15, 'hours': 0, 'minutes': 0}	=	58	3301
3850	{'parameters': [{'id': 67, 'name': 'position', 'type': 'bin', 'values': ['Open', 'Closed']}], 'parameterVals': [{'value': 'Closed', 'comparator': '='}], 'text': "Smart Oven's door Closes", 'capability': {'id': 60, 'name': 'Open/Close Door', 'label': "{DEVICE}'s door {position/T|Opens}{position/F|Closes}"}, 'channel': {'icon': 'fastfood', 'id': 13, 'name': 'Food & Cooking'}, 'device': {'id': 23, 'name': 'Smart Oven'}}	=	57	3302
3851	{'seconds': 1, 'hours': 0, 'minutes': 0}	=	58	3302
3852	Kitchen	 	70	3303
3853	Bobbie	 	71	3303
3854	40	>	75	3304
3855	Off	=	1	3305
3856	Day	=	62	3306
3857	Off	=	1	3307
3858	Asleep	=	68	3308
3859	On	=	1	3309
3860	On	=	1	3310
3861	Open	=	13	3311
3862	Raining	=	20	3312
3863	80	>	18	3313
3868	01:00	>	23	3317
3869	On	=	64	3318
3870	79	>	18	3319
3871	Open	=	13	3320
3872	60	<	18	3321
3873	Open	=	67	3322
3874	Closed	=	13	3323
3875	Closed	=	13	3324
3876	Pop	!=	8	3325
3877	Off	=	64	3326
3878	70	<	18	3327
3879	Closed	=	13	3328
3880	Closed	=	13	3329
3881	Raining	=	20	3330
3882	Open	=	13	3331
3883	Open	=	13	3332
3884	Home	 	70	3333
3885	Anyone	 	71	3333
3887	60	>	18	3335
3889	Bathroom	!=	70	3337
3890	Anyone	=	71	3337
3891	80	>	18	3338
3892	Open	=	13	3339
3893	{'parameters': [{'id': 12, 'name': 'setting', 'type': 'bin', 'values': ['Locked', 'Unlocked']}], 'parameterVals': [{'value': 'Locked', 'comparator': '='}], 'text': 'Front Door Lock Locks', 'capability': {'id': 13, 'name': 'Lock/Unlock', 'label': '{DEVICE} {setting/T|Locks}{setting/F|Unlocks}'}, 'channel': {'icon': 'meeting_room', 'id': 5, 'name': 'Windows & Doors'}, 'device': {'id': 13, 'name': 'Front Door Lock'}}	=	57	3340
3894	{'seconds': 0, 'hours': 9, 'minutes': 0}	=	58	3340
3895	On	=	1	3341
3896	Home	 	70	3342
3897	A Guest	 	71	3342
3898	{'parameters': [{'id': 70, 'name': 'location', 'type': 'set', 'values': ['Home', 'Kitchen', 'Bedroom', 'Bathroom', 'Living Room']}, {'id': 71, 'name': 'who', 'type': 'set', 'values': ['Anyone', 'Alice', 'Bobbie', 'A Family Member', 'A Guest', 'Nobody']}], 'parameterVals': [{'value': 'Home', 'comparator': '='}, {'value': 'A Guest', 'comparator': ' '}], 'text': 'A Guest is in Home', 'capability': {'id': 63, 'name': 'Detect Presence', 'label': '{who/!=|Someone other than }{who} is {location/!=|not }in {location}'}, 'channel': {'icon': 'room', 'id': 15, 'name': 'Location'}, 'device': {'id': 12, 'name': 'Location Sensor'}}	=	57	3343
3899	{'seconds': 0, 'hours': 3, 'minutes': 0}	<	58	3343
3900	Closed	=	13	3344
3901	Closed	=	13	3345
3903	60	<	18	3347
3904	Open	=	13	3348
3905	02:00	=	23	3349
3906	On	=	1	3350
3907	80	>	18	3351
3908	Off	=	72	3352
3909	On	=	72	3353
3910	On	=	64	3354
3911	Home	 	70	3355
3912	Anyone	 	71	3355
3914	On	=	1	3357
3915	On	=	1	3358
3916	Home	!=	70	3359
3917	A Family Member	!=	71	3359
3918	75	=	21	3360
3919	Home	=	70	3361
3920	Nobody	 	71	3361
3921	Pop	=	8	3362
3922	Open	=	13	3363
3923	Raining	=	20	3364
3925	Open	=	13	3366
3926	80	>	18	3367
3927	72	=	21	3368
3928	Home	 	70	3369
3929	Anyone	 	71	3369
3930	Open	=	13	3370
3931	60	>	18	3371
3932	80	<	18	3372
3933	Not Raining	=	20	3373
3934	Closed	=	65	3374
3935	Home	 	70	3375
3936	Anyone	 	71	3375
3937	Open	=	13	3376
3938	60	<	18	3377
3939	Locked	=	12	3378
3940	Asleep	=	68	3379
3942	{'parameters': [{'id': 70, 'name': 'location', 'type': 'set', 'values': ['Home', 'Kitchen', 'Bedroom', 'Bathroom', 'Living Room']}, {'id': 71, 'name': 'who', 'type': 'set', 'values': ['Anyone', 'Alice', 'Bobbie', 'A Family Member', 'A Guest', 'Nobody']}], 'parameterVals': [{'value': 'Home', 'comparator': ' '}, {'value': 'Anyone', 'comparator': '='}], 'text': 'Anyone is in Home', 'capability': {'id': 63, 'name': 'Detect Presence', 'label': '{who/!=|Someone other than }{who} is {location/!=|not }in {location}'}, 'channel': {'icon': 'visibility', 'id': 6, 'name': 'Sensors'}, 'device': {'id': 12, 'name': 'Location Sensor'}}	=	55	3381
3943	{'seconds': 1, 'hours': 0, 'minutes': 0}	=	56	3381
3944	On	=	1	3382
3945	Home	=	70	3383
3946	A Guest	=	71	3383
3947	Off	=	72	3384
3948	On	=	72	3385
3949	Open	=	65	3386
3950	On	=	64	3387
3951	Home	!=	70	3388
3952	Anyone	=	71	3388
3953	Asleep	=	68	3389
3954	On	=	1	3390
3955	{'parameters': [{'id': 68, 'name': 'status', 'type': 'bin', 'values': ['Awake', 'Asleep']}], 'parameterVals': [{'value': 'Asleep', 'comparator': '='}], 'text': '(FitBit) I Fall Asleep', 'capability': {'id': 61, 'name': 'Sleep Sensor', 'label': '({DEVICE}) I {status/T|Wake Up}{status/F|Fall Asleep}'}, 'channel': {'icon': 'favorite_border', 'id': 16, 'name': 'Health'}, 'device': {'id': 21, 'name': 'FitBit'}}	=	57	3391
3956	{'seconds': 0, 'hours': 0, 'minutes': 30}	=	58	3391
3957	Open	=	67	3392
3958	Closed	=	65	3393
3959	On	=	1	3394
3960	Open	=	65	3395
3961	Pop	=	8	3396
3962	 	=	72	3397
3963	Open	=	13	3398
3964	80	<	18	3399
3965	60	>	18	3400
3966	{'parameters': [{'id': 67, 'name': 'position', 'type': 'bin', 'values': ['Open', 'Closed']}], 'parameterVals': [{'value': 'Open', 'comparator': '='}], 'text': "Smart Refrigerator's door Opens", 'capability': {'id': 60, 'name': 'Open/Close Door', 'label': "{DEVICE}'s door {position/T|Opens}{position/F|Closes}"}, 'channel': {'icon': 'fastfood', 'id': 13, 'name': 'Food & Cooking'}, 'device': {'id': 8, 'name': 'Smart Refrigerator'}}	=	57	3401
3967	{'seconds': 0, 'hours': 0, 'minutes': 2}	>	58	3401
3968	Open	=	67	3402
3969	Open	=	65	3403
3970	{'parameters': [{'id': 67, 'name': 'position', 'type': 'bin', 'values': ['Open', 'Closed']}], 'parameterVals': [{'value': 'Open', 'comparator': '='}], 'text': "Smart Refrigerator's door Opens", 'capability': {'id': 60, 'name': 'Open/Close Door', 'label': "{DEVICE}'s door {position/T|Opens}{position/F|Closes}"}, 'channel': {'icon': 'fastfood', 'id': 13, 'name': 'Food & Cooking'}, 'device': {'id': 8, 'name': 'Smart Refrigerator'}}	=	57	3404
3971	{'seconds': 0, 'hours': 0, 'minutes': 2}	>	58	3404
3972	Open	=	67	3405
3973	On	=	1	3406
3974	Locked	=	12	3407
3975	{'parameters': [{'id': 67, 'name': 'position', 'type': 'bin', 'values': ['Open', 'Closed']}], 'parameterVals': [{'value': 'Open', 'comparator': '='}], 'text': "Smart Refrigerator's door Opens", 'capability': {'id': 60, 'name': 'Open/Close Door', 'label': "{DEVICE}'s door {position/T|Opens}{position/F|Closes}"}, 'channel': {'icon': 'fastfood', 'id': 13, 'name': 'Food & Cooking'}, 'device': {'id': 8, 'name': 'Smart Refrigerator'}}	=	57	3408
3976	{'seconds': 0, 'hours': 0, 'minutes': 2}	>	58	3408
3977	Open	=	67	3409
3978	Motion	=	14	3410
3979	On	=	1	3411
3980	Living Room	!=	70	3412
3981	A Guest	!=	71	3412
3982	Off	=	1	3413
3983	Asleep	=	68	3414
3984	Unlocked	=	12	3415
3985	Home	 	70	3416
3986	Alice	=	71	3416
3987	Night	=	62	3417
3988	Pop	=	8	3418
3989	40	=	75	3419
3990	Open	=	65	3420
3991	Open	=	13	3421
3992	61	=	18	3422
3993	79	=	18	3423
3994	Not Raining	=	20	3424
3995	Open	=	65	3425
3996	On	=	1	3426
3997	{'parameters': [{'id': 1, 'name': 'setting', 'type': 'bin', 'values': ['On', 'Off']}], 'parameterVals': [{'value': 'On', 'comparator': '='}], 'text': 'Roomba turns On', 'capability': {'id': 2, 'name': 'Power On/Off', 'label': '{DEVICE} turns {setting}'}, 'channel': {'icon': 'build', 'id': 18, 'name': 'Cleaning'}, 'device': {'id': 1, 'name': 'Roomba'}}	=	52	3427
3998	{'seconds': 0, 'hours': 72, 'minutes': 0}	=	53	3427
3999	1	=	54	3427
4002	On	=	1	3429
4003	Open	=	65	3430
4004	On	=	1	3431
4005	Open	=	65	3432
4006	On	=	1	3433
4007	Closed	=	65	3434
4008	On	=	1	3435
4009	On	=	1	3436
4010	Home	 	70	3437
4011	A Guest	 	71	3437
4012	{'parameters': [{'id': 1, 'name': 'setting', 'type': 'bin', 'values': ['On', 'Off']}], 'parameterVals': [{'value': 'On', 'comparator': '='}], 'text': 'Roomba is On', 'capability': {'id': 2, 'name': 'Power On/Off', 'label': '{DEVICE} is {setting}'}, 'channel': {'icon': 'build', 'id': 18, 'name': 'Cleaning'}, 'device': {'id': 1, 'name': 'Roomba'}}	=	57	3438
4013	{'seconds': 1, 'hours': 3, 'minutes': 0}	>	58	3438
4014	Off	=	1	3439
4015	Closed	=	65	3440
4016	Home	=	70	3441
4017	Anyone	=	71	3441
4018	72	=	18	3442
4019	Off	=	1	3443
4020	Night	=	62	3444
4021	80	=	18	3445
4022	80	<	21	3446
4023	Off	=	64	3447
4024	Off	=	1	3448
4025	Closed	=	65	3449
4026	80	>	21	3450
4027	Open	=	13	3451
4028	60	>	18	3452
4029	80	!=	18	3453
4030	Off	=	1	3454
4031	Living Room	 	70	3455
4032	A Family Member	!=	71	3455
4033	Off	=	1	3456
4034	Closed	=	65	3457
4035	On	=	1	3458
4036	Asleep	=	68	3459
4039	80	=	18	3462
4040	80	=	18	3463
4041	81	<	21	3464
4042	Off	=	64	3465
4043	Open	=	13	3466
4044	Raining	=	20	3467
4045	Locked	=	12	3468
4046	Night	=	62	3469
4047	Home	=	70	3470
4048	Anyone	=	71	3470
4049	On	=	1	3471
4050	Open	=	65	3472
4051	80	>	18	3473
4052	80	>	21	3474
4053	Off	=	64	3475
4054	On	=	1	3476
4055	Open	=	65	3477
4056	Closed	=	13	3478
4057	80	>	18	3479
4059	On	=	1	3481
4060	Open	=	65	3482
4061	Closed	=	13	3483
4062	60	<	18	3484
4063	Pop	!=	8	3485
4064	Pop	 	8	3486
4065	23:00	>	23	3487
4066	Locked	=	12	3488
4067	Off	=	1	3489
4068	Asleep	=	68	3490
4069	Closed	=	13	3491
4070	Closed	=	13	3492
4071	Closed	=	13	3493
4073	Off	=	1	3495
4074	Asleep	=	68	3496
4075	Closed	=	13	3497
4076	Closed	=	13	3498
4077	Closed	=	13	3499
4079	Off	=	72	3501
4080	On	=	72	3502
4081	Closed	=	13	3503
4082	Closed	=	13	3504
4083	Closed	=	13	3505
4084	Off	=	72	3506
4085	On	=	72	3507
4086	{'parameters': [{'id': 68, 'name': 'status', 'type': 'bin', 'values': ['Awake', 'Asleep']}], 'parameterVals': [{'value': 'Asleep', 'comparator': '='}], 'text': '(FitBit) I Fall Asleep', 'capability': {'id': 61, 'name': 'Sleep Sensor', 'label': '({DEVICE}) I {status/T|Wake Up}{status/F|Fall Asleep}'}, 'channel': {'icon': 'visibility', 'id': 6, 'name': 'Sensors'}, 'device': {'id': 21, 'name': 'FitBit'}}	=	57	3508
4087	{'seconds': 0, 'hours': 0, 'minutes': 30}	>	58	3508
4088	On	=	1	3509
4089	Closed	=	13	3510
4090	Closed	=	13	3511
4091	Closed	=	13	3512
4092	Open	=	13	3513
4093	79	>	18	3514
4094	60	<	18	3515
4095	Not Raining	=	20	3516
4096	80	>	21	3517
4098	{'parameters': [{'id': 68, 'name': 'status', 'type': 'bin', 'values': ['Awake', 'Asleep']}], 'parameterVals': [{'value': 'Asleep', 'comparator': '='}], 'text': '(FitBit) I Fall Asleep', 'capability': {'id': 61, 'name': 'Sleep Sensor', 'label': '({DEVICE}) I {status/T|Wake Up}{status/F|Fall Asleep}'}, 'channel': {'icon': 'visibility', 'id': 6, 'name': 'Sensors'}, 'device': {'id': 21, 'name': 'FitBit'}}	=	57	3519
4099	{'seconds': 0, 'hours': 0, 'minutes': 30}	>	58	3519
4100	On	=	1	3520
4101	Asleep	=	68	3521
4102	On	=	1	3522
4103	Open	=	65	3523
4104	Closed	=	67	3524
4105	Open	=	67	3525
4106	On	=	1	3526
4107	Open	=	65	3527
4108	On	=	1	3528
4109	Open	=	65	3529
4110	On	=	1	3530
4111	Home	 	70	3531
4112	Alice	!=	71	3531
4113	Home	 	70	3532
4114	Bobbie	!=	71	3532
4117	Kitchen	!=	70	3534
4118	Anyone	=	71	3534
4120	80	<	18	3536
4121	60	>	18	3537
4122	Not Raining	=	20	3538
4123	Night	=	62	3539
4124	{'parameters': [{'id': 1, 'name': 'setting', 'type': 'bin', 'values': ['On', 'Off']}], 'parameterVals': [{'value': 'On', 'comparator': '='}], 'text': 'Roomba is On', 'capability': {'id': 2, 'name': 'Power On/Off', 'label': '{DEVICE} is {setting}'}, 'channel': {'icon': 'build', 'id': 18, 'name': 'Cleaning'}, 'device': {'id': 1, 'name': 'Roomba'}}	=	55	3540
4125	{'seconds': 0, 'hours': 1, 'minutes': 0}	=	56	3540
4126	Home	=	70	3541
4127	Anyone	 	71	3541
4128	70	>	21	3542
4129	75	<	21	3543
4131	On	=	1	3545
4135	16:00	=	23	3547
4136	{'parameters': [{'id': 1, 'name': 'setting', 'type': 'bin', 'values': ['On', 'Off']}], 'parameterVals': [{'value': 'Off', 'comparator': '='}], 'text': 'Roomba is Off', 'capability': {'id': 2, 'name': 'Power On/Off', 'label': '{DEVICE} is {setting}'}, 'channel': {'icon': 'build', 'id': 18, 'name': 'Cleaning'}, 'device': {'id': 1, 'name': 'Roomba'}}	=	55	3548
4137	{'seconds': 0, 'hours': 48, 'minutes': 0}	=	56	3548
4138	Open	=	65	3549
4139	Open	=	65	3550
4140	Open	=	65	3551
4141	Open	=	65	3552
4142	On	=	1	3553
4144	On	=	1	3555
4145	76	=	18	3556
4146	40	>	18	3557
4147	Unlocked	=	12	3558
4148	Kitchen	=	70	3559
4149	Bobbie	=	71	3559
4150	75	>	18	3560
4151	75	>	18	3561
4152	80	>	18	3562
4153	80	=	18	3563
4154	Pop	=	8	3564
4155	Open	=	67	3565
4158	Open	=	13	3567
4159	70	=	21	3568
4160	Raining	=	20	3569
4161	{'parameters': [{'id': 72, 'name': 'setting', 'type': 'bin', 'values': ['On', 'Off']}], 'parameterVals': [{'value': ' ', 'comparator': '='}], 'text': "Smart Faucet's water is running", 'capability': {'id': 64, 'name': 'Water On/Off', 'label': "{DEVICE}'s water is {setting/F|not }running"}, 'channel': {'icon': 'local_drink', 'id': 17, 'name': 'Water & Plumbing'}, 'device': {'id': 22, 'name': 'Smart Faucet'}}	=	55	3570
4162	{'seconds': 15, 'hours': 0, 'minutes': 0}	=	56	3570
4165	 	=	72	3572
4166	Home	!=	70	3573
4167	Alice	=	71	3573
4168	Home	 	70	3574
4169	Nobody	 	71	3574
4170	 	=	72	3575
4171	Home	!=	70	3576
4172	Bobbie	=	71	3576
4173	Home	=	70	3577
4174	Nobody	=	71	3577
4176	 	=	72	3579
4177	Locked	=	12	3580
4178	Kitchen	=	70	3581
4179	Bobbie	=	71	3581
4180	70	>	21	3582
4181	Home	=	70	3583
4182	Anyone	 	71	3583
4183	75	<	21	3584
4184	Home	=	70	3585
4185	Anyone	 	71	3585
4186	Closed	=	13	3586
4187	Closed	=	13	3587
4188	Closed	=	65	3588
4189	Closed	=	13	3589
4190	Closed	=	13	3590
4191	Closed	=	13	3591
4192	08:00	=	23	3592
4193	Closed	=	13	3593
4194	Closed	=	13	3594
4195	Closed	=	13	3595
4196	Closed	=	13	3596
4197	Closed	=	13	3597
4198	Closed	=	13	3598
4200	Off	=	1	3600
4201	Home	=	70	3601
4202	A Family Member	=	71	3601
4204	80	>	21	3603
4205	Closed	=	13	3604
4206	Closed	=	13	3605
4207	Closed	=	13	3606
4208	Pop music	=	35	3607
4210	Night	=	62	3609
4211	Bedroom	=	70	3610
4212	Anyone	=	71	3610
4213	Off	=	1	3611
4214	No Motion	=	14	3612
4215	{'parameters': [{'id': 14, 'name': 'status', 'type': 'bin', 'values': ['Motion', 'No Motion']}], 'parameterVals': [{'value': 'No Motion', 'comparator': '='}], 'text': 'Security Camera Stops Detecting Motion', 'capability': {'id': 15, 'name': 'Detect Motion', 'label': '{DEVICE} {status/T|Starts}{status/F|Stops} Detecting Motion'}, 'channel': {'icon': 'visibility', 'id': 6, 'name': 'Sensors'}, 'device': {'id': 10, 'name': 'Security Camera'}}	=	57	3613
4216	{'seconds': 0, 'hours': 0, 'minutes': 30}	>	58	3613
4217	On	=	1	3614
4218	Asleep	=	68	3615
4219	41	<	18	3616
4220	 	=	72	3617
4221	46	=	18	3618
4222	On	=	72	3619
4223	45	>	18	3620
4224	On	=	72	3621
4225	Unlocked	=	12	3622
4226	Asleep	=	68	3623
4227	On	=	72	3624
4228	Pop	=	8	3625
4229	Open	=	13	3626
4230	Pop	 	8	3627
4231	{'parameters': [{'id': 70, 'name': 'location', 'type': 'set', 'values': ['Home', 'Kitchen', 'Bedroom', 'Bathroom', 'Living Room']}, {'id': 71, 'name': 'who', 'type': 'set', 'values': ['Anyone', 'Alice', 'Bobbie', 'A Family Member', 'A Guest', 'Nobody']}], 'parameterVals': [{'value': 'Home', 'comparator': '='}, {'value': 'A Family Member', 'comparator': '!='}], 'text': 'Someone other than A Family Member Enters Home', 'capability': {'id': 63, 'name': 'Detect Presence', 'label': '{who/=|}{who/!=|Someone other than }{who} {location/=|Enters}{location/!=|Exits} {location}'}, 'channel': {'icon': 'room', 'id': 15, 'name': 'Location'}, 'device': {'id': 12, 'name': 'Location Sensor'}}	=	57	3628
4232	{'seconds': 0, 'hours': 3, 'minutes': 0}	=	58	3628
4427	pop music	=	35	3793
4428	Raining	=	17	3794
4433	Anyone	=	71	3798
4434	Pop	=	8	3799
4435	Pop	=	8	3800
4436	Closed	=	13	3801
4437	Day	=	62	3802
4438	Pop	=	8	3803
4439	Pop	=	8	3804
4440	On	=	1	3805
4233	{'parameters': [{'id': 70, 'name': 'location', 'type': 'set', 'values': ['Home', 'Kitchen', 'Bedroom', 'Bathroom', 'Living Room']}, {'id': 71, 'name': 'who', 'type': 'set', 'values': ['Anyone', 'Alice', 'Bobbie', 'A Family Member', 'A Guest', 'Nobody']}], 'parameterVals': [{'value': 'Home', 'comparator': '='}, {'value': 'A Family Member', 'comparator': '!='}], 'text': 'Someone other than A Family Member Enters Home', 'capability': {'id': 63, 'name': 'Detect Presence', 'label': '{who/=|}{who/!=|Someone other than }{who} {location/=|Enters}{location/!=|Exits} {location}'}, 'channel': {'icon': 'room', 'id': 15, 'name': 'Location'}, 'device': {'id': 12, 'name': 'Location Sensor'}}	=	57	3629
4234	{'seconds': 0, 'hours': 3, 'minutes': 0}	=	58	3629
4238	73	=	18	3633
4239	Home	 	70	3634
4240	Anyone	 	71	3634
4241	70	<	18	3635
4242	Home	=	70	3636
4243	Anyone	=	71	3636
4244	39	=	18	3637
4245	75	>	18	3638
4246	Home	=	70	3639
4247	Anyone	=	71	3639
4249	Closed	=	13	3641
4250	Closed	=	13	3642
4251	Asleep	=	68	3643
4252	On	=	1	3644
4253	80	=	18	3645
4254	70	<	18	3646
4255	Home	 	70	3647
4256	Nobody	 	71	3647
4257	On	=	64	3648
4258	80	>	18	3649
4259	Pop	=	8	3650
4260	60	<	18	3651
4261	80	>	18	3652
4262	Raining	=	20	3653
4263	81	=	18	3654
4264	40	=	75	3655
4265	Not Raining	=	20	3656
4266	81	=	18	3657
4267	80	=	18	3658
4268	Open	=	65	3659
4269	On	=	1	3660
4271	Kitchen	=	70	3662
4272	Bobbie	=	71	3662
4273	On	=	1	3663
4274	Closed	=	67	3664
4275	Kitchen	 	70	3665
4276	Bobbie	 	71	3665
4277	Open	=	65	3666
4278	On	=	1	3667
4279	40	<	18	3668
4280	Locked	=	12	3669
4281	Kitchen	 	70	3670
4282	Bobbie	 	71	3670
4283	Open	=	65	3671
4284	On	=	1	3672
4285	Pop	=	8	3673
4286	Pop	=	8	3674
4287	Asleep	=	68	3675
4288	On	=	1	3676
4289	{'parameters': [{'id': 68, 'name': 'status', 'type': 'bin', 'values': ['Awake', 'Asleep']}], 'parameterVals': [{'value': 'Asleep', 'comparator': '='}], 'text': '(FitBit) I Fall Asleep', 'capability': {'id': 61, 'name': 'Sleep Sensor', 'label': '({DEVICE}) I {status/T|Wake Up}{status/F|Fall Asleep}'}, 'channel': {'icon': 'visibility', 'id': 6, 'name': 'Sensors'}, 'device': {'id': 21, 'name': 'FitBit'}}	=	57	3677
4290	{'seconds': 0, 'hours': 0, 'minutes': 31}	=	58	3677
4291	Closed	=	67	3678
4292	Open	=	67	3679
4293	Clear	=	17	3680
4294	Not Raining	=	20	3681
4295	60	<	18	3682
4296	Closed	=	65	3683
4297	Day	=	62	3684
4298	80	=	18	3685
4299	80	>	18	3686
4300	On	=	1	3687
4301	Open	=	65	3688
4302	On	=	1	3689
4303	Open	=	65	3690
4304	Off	=	1	3691
4305	Home	 	70	3692
4306	A Guest	 	71	3692
4307	On	=	1	3693
4308	Open	=	65	3694
4309	Open	=	65	3695
4310	Open	=	65	3696
4311	Open	=	65	3697
4312	Raining	=	17	3698
4313	80	>	18	3699
4314	Unlocked	=	12	3700
4315	Asleep	=	68	3701
4316	 	=	72	3702
4317	Kitchen	=	70	3703
4318	Bobbie	=	71	3703
4319	On	=	1	3704
4321	On	=	1	3706
4322	Home	=	70	3707
4323	A Guest	 	71	3707
4324	{'parameters': [{'id': 70, 'name': 'location', 'type': 'set', 'values': ['Home', 'Kitchen', 'Bedroom', 'Bathroom', 'Living Room']}, {'id': 71, 'name': 'who', 'type': 'set', 'values': ['Anyone', 'Alice', 'Bobbie', 'A Family Member', 'A Guest', 'Nobody']}], 'parameterVals': [{'value': 'Home', 'comparator': '='}, {'value': 'A Guest', 'comparator': '='}], 'text': 'A Guest Enters Home', 'capability': {'id': 63, 'name': 'Detect Presence', 'label': '{who/=|}{who/!=|Someone other than }{who} {location/=|Enters}{location/!=|Exits} {location}'}, 'channel': {'icon': 'visibility', 'id': 6, 'name': 'Sensors'}, 'device': {'id': 12, 'name': 'Location Sensor'}}	=	57	3708
4325	{'seconds': 0, 'hours': 3, 'minutes': 0}	<	58	3708
4326	Closed	=	67	3709
4327	Open	=	67	3710
4328	Closed	=	13	3711
4329	Closed	=	13	3712
4330	Closed	=	13	3713
4331	Closed	=	13	3714
4332	40	<	18	3715
4333	Closed	=	13	3716
4334	Closed	=	13	3717
4335	Kitchen	=	70	3718
4336	Bobbie	=	71	3718
4337	On	=	1	3719
4338	Unlocked	=	12	3720
4339	Asleep	=	68	3721
4340	Unlocked	=	12	3722
4341	{'parameters': [{'id': 72, 'name': 'setting', 'type': 'bin', 'values': ['On', 'Off']}], 'parameterVals': [{'value': 'On', 'comparator': '='}], 'text': "Smart Faucet's water Turns On", 'capability': {'id': 64, 'name': 'Water On/Off', 'label': "{DEVICE}'s water {setting/T|Turns On}{setting/F|Turns Off}"}, 'channel': {'icon': 'local_drink', 'id': 17, 'name': 'Water & Plumbing'}, 'device': {'id': 22, 'name': 'Smart Faucet'}}	=	57	3723
4342	{'seconds': 15, 'hours': 0, 'minutes': 0}	=	58	3723
4344	Open	=	67	3725
4345	On	=	1	3726
4346	Asleep	=	68	3727
4421	On	=	1	3787
4422	00:00	>	23	3788
4429	75	=	21	3795
4430	Sunny	=	17	3796
4431	69	=	21	3797
4432	Bathroom	=	70	3798
4347	{'parameters': [{'id': 67, 'name': 'position', 'type': 'bin', 'values': ['Open', 'Closed']}], 'parameterVals': [{'value': 'Open', 'comparator': '='}], 'text': "Smart Refrigerator's door Opens", 'capability': {'id': 60, 'name': 'Open/Close Door', 'label': "{DEVICE}'s door {position/T|Opens}{position/F|Closes}"}, 'channel': {'icon': 'fastfood', 'id': 13, 'name': 'Food & Cooking'}, 'device': {'id': 8, 'name': 'Smart Refrigerator'}}	=	57	3728
4348	{'seconds': 0, 'hours': 0, 'minutes': 2}	>	58	3728
4349	Open	=	67	3729
4350	{'parameters': [{'id': 67, 'name': 'position', 'type': 'bin', 'values': ['Open', 'Closed']}], 'parameterVals': [{'value': 'Open', 'comparator': '='}], 'text': "Smart Refrigerator's door is Open", 'capability': {'id': 60, 'name': 'Open/Close Door', 'label': "{DEVICE}'s door is {position}"}, 'channel': {'icon': 'fastfood', 'id': 13, 'name': 'Food & Cooking'}, 'device': {'id': 8, 'name': 'Smart Refrigerator'}}	=	55	3730
4351	{'seconds': 0, 'hours': 0, 'minutes': 2}	>	56	3730
4445	Closed	=	65	3809
4446	On	=	72	3810
4447	On	=	1	3811
4448	Closed	=	67	3812
4449	Home	!=	70	3813
4450	Bobbie	!=	71	3813
4451	80	>	18	3814
4452	Bedroom	=	70	3815
4352	{'parameters': [{'id': 72, 'name': 'setting', 'type': 'bin', 'values': ['On', 'Off']}], 'parameterVals': [{'value': 'On', 'comparator': '='}], 'text': "Smart Faucet's water Turns On", 'capability': {'id': 64, 'name': 'Water On/Off', 'label': "{DEVICE}'s water {setting/T|Turns On}{setting/F|Turns Off}"}, 'channel': {'icon': 'fastfood', 'id': 13, 'name': 'Food & Cooking'}, 'device': {'id': 22, 'name': 'Smart Faucet'}}	=	57	3731
4353	{'seconds': 15, 'hours': 0, 'minutes': 0}	=	58	3731
4354	Home	=	70	3732
4355	Bobbie	!=	71	3732
4356	On	=	1	3733
4357	{'parameters': [{'id': 67, 'name': 'position', 'type': 'bin', 'values': ['Open', 'Closed']}], 'parameterVals': [{'value': 'Closed', 'comparator': '='}], 'text': "Smart Refrigerator's door is Closed", 'capability': {'id': 60, 'name': 'Open/Close Door', 'label': "{DEVICE}'s door is {position}"}, 'channel': {'icon': 'fastfood', 'id': 13, 'name': 'Food & Cooking'}, 'device': {'id': 8, 'name': 'Smart Refrigerator'}}	=	55	3734
4358	{'seconds': 0, 'hours': 0, 'minutes': 2}	=	56	3734
4359	Asleep	=	68	3735
4360	On	=	1	3736
4361	{'parameters': [{'id': 67, 'name': 'position', 'type': 'bin', 'values': ['Open', 'Closed']}], 'parameterVals': [{'value': 'Open', 'comparator': '='}], 'text': "Smart Refrigerator's door is Open", 'capability': {'id': 60, 'name': 'Open/Close Door', 'label': "{DEVICE}'s door is {position}"}, 'channel': {'icon': 'fastfood', 'id': 13, 'name': 'Food & Cooking'}, 'device': {'id': 8, 'name': 'Smart Refrigerator'}}	=	55	3737
4362	{'seconds': 0, 'hours': 0, 'minutes': 2}	>	56	3737
4363	Open	=	67	3738
4364	{'parameters': [{'id': 67, 'name': 'position', 'type': 'bin', 'values': ['Open', 'Closed']}], 'parameterVals': [{'value': 'Closed', 'comparator': '='}], 'text': "Smart Refrigerator's door is Closed", 'capability': {'id': 60, 'name': 'Open/Close Door', 'label': "{DEVICE}'s door is {position}"}, 'channel': {'icon': 'fastfood', 'id': 13, 'name': 'Food & Cooking'}, 'device': {'id': 8, 'name': 'Smart Refrigerator'}}	=	55	3739
4365	{'seconds': 0, 'hours': 0, 'minutes': 2}	>	56	3739
4366	On	=	1	3740
4367	On	=	1	3741
4368	On	=	1	3742
4369	Night	=	62	3743
4370	Home	=	70	3744
4371	A Family Member	!=	71	3744
4372	Locked	=	12	3745
4373	{'parameters': [{'id': 14, 'name': 'status', 'type': 'bin', 'values': ['Motion', 'No Motion']}], 'parameterVals': [{'value': 'No Motion', 'comparator': '='}], 'text': 'Security Camera Stops Detecting Motion', 'capability': {'id': 15, 'name': 'Detect Motion', 'label': '{DEVICE} {status/T|Starts}{status/F|Stops} Detecting Motion'}, 'channel': {'icon': 'visibility', 'id': 6, 'name': 'Sensors'}, 'device': {'id': 10, 'name': 'Security Camera'}}	=	57	3746
4374	{'seconds': 0, 'hours': 0, 'minutes': 30}	=	58	3746
4375	{'parameters': [{'id': 13, 'name': 'position', 'type': 'bin', 'values': ['Open', 'Closed']}], 'parameterVals': [{'value': 'Closed', 'comparator': '='}], 'text': 'Bathroom Window is Closed', 'capability': {'id': 14, 'name': 'Open/Close Window', 'label': '{DEVICE} is {position}'}, 'channel': {'icon': 'meeting_room', 'id': 5, 'name': 'Windows & Doors'}, 'device': {'id': 24, 'name': 'Bathroom Window'}}	=	50	3747
4376	{'seconds': 0, 'hours': 0, 'minutes': 0}	=	51	3747
4377	Closed	=	13	3748
4378	Closed	=	13	3749
4379	4	>	2	3750
4380	22	=	18	3751
4381	Open	=	65	3752
4382	Open	=	13	3753
4383	80	>	18	3754
4384	60	<	18	3755
4385	Raining	=	20	3756
4386	Open	=	13	3757
4387	80	>	18	3758
4388	60	<	18	3759
4389	Raining	=	20	3760
4390	Open	=	65	3761
4391	On	=	1	3762
4393	On	=	1	3764
4394	40	<	18	3765
4395	{'parameters': [{'id': 72, 'name': 'setting', 'type': 'bin', 'values': ['On', 'Off']}], 'parameterVals': [{'value': ' ', 'comparator': '='}], 'text': "Smart Faucet's water is running", 'capability': {'id': 64, 'name': 'Water On/Off', 'label': "{DEVICE}'s water is {setting/F|not }running"}, 'channel': {'icon': 'local_drink', 'id': 17, 'name': 'Water & Plumbing'}, 'device': {'id': 22, 'name': 'Smart Faucet'}}	=	50	3766
4396	{'seconds': 15, 'hours': 0, 'minutes': 0}	=	51	3766
4397	On	=	72	3767
4400	Off	=	72	3769
4401	On	=	1	3770
4402	Off	=	72	3771
4403	Kitchen	=	70	3772
4404	A Family Member	!=	71	3772
4405	Pop	=	8	3773
4407	Kitchen	 	70	3775
4408	Bobbie	 	71	3775
4409	Open	=	67	3776
4410	88	=	18	3777
4411	83	=	18	3778
4412	Closed	=	13	3779
4413	Clear	 	17	3780
4416	Raining	=	20	3782
4417	758	!=	36	3783
4418	Jazz	=	8	3784
4419	animal planet	!=	37	3785
4423	Open	=	65	3789
4424	Partly Cloudy	=	17	3790
4425	Raining	=	20	3791
4426	Snowing	=	17	3792
4441	Home	!=	70	3806
4442	Nobody	 	71	3806
4443	Closed	=	65	3807
4444	Closed	=	65	3808
4453	Anyone	=	71	3815
4454	{'parameters': [{'id': 68, 'name': 'status', 'type': 'bin', 'values': ['Awake', 'Asleep']}], 'parameterVals': [{'value': 'Asleep', 'comparator': '='}], 'text': '(FitBit) I am Asleep', 'capability': {'id': 61, 'name': 'Sleep Sensor', 'label': '({DEVICE}) I am {status}'}, 'channel': {'icon': 'favorite_border', 'id': 16, 'name': 'Health'}, 'device': {'id': 21, 'name': 'FitBit'}}	=	50	3816
4455	{'seconds': 0, 'hours': 0, 'minutes': 30}	=	51	3816
4456	Asleep	=	68	3817
4457	Unlocked	=	12	3818
4458	Home	=	70	3819
4459	Anyone	=	71	3819
4460	Closed	=	13	3820
4461	Closed	=	13	3821
4462	Closed	=	13	3822
4463	Off	=	72	3823
4464	On	=	72	3824
4465	Locked	=	12	3825
4466	200	>	74	3826
4467	Bedroom	=	70	3827
4468	Anyone	=	71	3827
4469	Not Raining	=	20	3828
4470	80	<	18	3829
4471	60	>	18	3830
4472	Bedroom	=	70	3831
4473	Anyone	=	71	3831
4474	Not Raining	=	20	3832
4475	80	<	18	3833
4476	60	>	18	3834
4477	On	=	1	3835
4478	Open	=	65	3836
4479	80	>	18	3837
4480	On	=	1	3838
4481	Open	=	65	3839
4482	On	=	1	3840
4483	Open	=	65	3841
4484	Open	=	13	3842
4485	Open	=	13	3843
4486	Pop	=	8	3844
4487	{'parameters': [{'id': 72, 'name': 'setting', 'type': 'bin', 'values': ['On', 'Off']}], 'parameterVals': [{'value': 'On', 'comparator': '='}], 'text': "Smart Faucet's water Turns On", 'capability': {'id': 64, 'name': 'Water On/Off', 'label': "{DEVICE}'s water {setting/T|Turns On}{setting/F|Turns Off}"}, 'channel': {'icon': 'local_drink', 'id': 17, 'name': 'Water & Plumbing'}, 'device': {'id': 22, 'name': 'Smart Faucet'}}	=	57	3845
4488	{'seconds': 15, 'hours': 0, 'minutes': 0}	>	58	3845
4490	Pop	=	8	3847
4491	On	=	1	3848
4492	18:00	>	23	3849
4493	Kitchen	=	70	3850
4494	Bobbie	=	71	3850
4495	Open	=	13	3851
4496	80	<	18	3852
4497	60	>	18	3853
4498	Not Raining	=	20	3854
4503	Home	!=	70	3857
4504	Anyone	=	71	3857
4505	75	>	18	3858
4506	Home	=	70	3859
4507	Anyone	=	71	3859
4508	70	<	18	3860
4509	Home	=	70	3861
4510	Anyone	=	71	3861
4511	73	<	18	3862
4512	73	<	18	3863
4513	Home	=	70	3864
4514	Anyone	=	71	3864
4515	On	=	64	3865
4516	Home	=	70	3866
4517	Nobody	=	71	3866
4518	66	>	21	3867
4519	Home	=	70	3868
4520	Nobody	=	71	3868
4521	62	>	18	3869
4522	Home	=	70	3870
4523	Nobody	=	71	3870
4524	{'parameters': [{'id': 68, 'name': 'status', 'type': 'bin', 'values': ['Awake', 'Asleep']}], 'parameterVals': [{'value': 'Asleep', 'comparator': '='}], 'text': '(FitBit) I Fall Asleep', 'capability': {'id': 61, 'name': 'Sleep Sensor', 'label': '({DEVICE}) I {status/T|Wake Up}{status/F|Fall Asleep}'}, 'channel': {'icon': 'favorite_border', 'id': 16, 'name': 'Health'}, 'device': {'id': 21, 'name': 'FitBit'}}	=	57	3871
4525	{'seconds': 0, 'hours': 0, 'minutes': 30}	>	58	3871
4526	On	=	1	3872
4527	{'parameters': [{'id': 70, 'name': 'location', 'type': 'set', 'values': ['Home', 'Kitchen', 'Bedroom', 'Bathroom', 'Living Room']}, {'id': 71, 'name': 'who', 'type': 'set', 'values': ['Anyone', 'Alice', 'Bobbie', 'A Family Member', 'A Guest', 'Nobody']}], 'parameterVals': [{'value': 'Home', 'comparator': '='}, {'value': 'A Family Member', 'comparator': '!='}], 'text': 'Someone other than A Family Member Enters Home', 'capability': {'id': 63, 'name': 'Detect Presence', 'label': '{who/=|}{who/!=|Someone other than }{who} {location/=|Enters}{location/!=|Exits} {location}'}, 'channel': {'icon': 'room', 'id': 15, 'name': 'Location'}, 'device': {'id': 12, 'name': 'Location Sensor'}}	=	57	3873
4528	{'seconds': 0, 'hours': 3, 'minutes': 0}	<	58	3873
4529	{'parameters': [{'id': 70, 'name': 'location', 'type': 'set', 'values': ['Home', 'Kitchen', 'Bedroom', 'Bathroom', 'Living Room']}, {'id': 71, 'name': 'who', 'type': 'set', 'values': ['Anyone', 'Alice', 'Bobbie', 'A Family Member', 'A Guest', 'Nobody']}], 'parameterVals': [{'value': 'Home', 'comparator': '='}, {'value': 'A Family Member', 'comparator': '!='}], 'text': 'Someone other than A Family Member Enters Home', 'capability': {'id': 63, 'name': 'Detect Presence', 'label': '{who/=|}{who/!=|Someone other than }{who} {location/=|Enters}{location/!=|Exits} {location}'}, 'channel': {'icon': 'room', 'id': 15, 'name': 'Location'}, 'device': {'id': 12, 'name': 'Location Sensor'}}	=	57	3874
4530	{'seconds': 0, 'hours': 3, 'minutes': 0}	>	58	3874
4531	Kitchen	=	70	3875
4532	Bobbie	=	71	3875
4533	On	=	1	3876
4534	Open	=	65	3877
4535	Off	=	1	3878
4536	Motion	=	14	3879
4537	80	>	18	3880
4538	On	=	1	3881
4539	Asleep	=	68	3882
4540	Closed	=	13	3883
4541	Closed	=	13	3884
4542	Closed	=	13	3885
4543	Closed	=	13	3886
4544	Closed	=	13	3887
4545	Closed	=	13	3888
4546	Closed	=	13	3889
4547	Closed	=	13	3890
4548	Closed	=	13	3891
4549	Unlocked	=	12	3892
4550	Locked	=	12	3893
4551	Asleep	=	68	3894
4552	Asleep	=	68	3895
4553	Unlocked	=	12	3896
4554	Asleep	=	68	3897
4555	Open	=	13	3898
4556	60	>	18	3899
4557	80	<	18	3900
4558	Not Raining	=	20	3901
4559	Asleep	=	68	3902
4560	Unlocked	=	12	3903
4561	73	=	21	3904
4562	Home	=	70	3905
4563	Anyone	=	71	3905
4564	Closed	=	65	3906
4565	On	=	1	3907
4566	40	<	75	3908
4567	40	<	75	3909
4568	Open	=	65	3910
4569	On	=	1	3911
4570	Home	=	70	3912
4571	A Family Member	 	71	3912
4572	Home	 	70	3913
4573	A Guest	 	71	3913
4574	Pop	=	8	3914
4575	Open	=	67	3915
4576	Open	=	67	3916
4577	Closed	=	67	3917
4578	80	=	18	3918
4579	On	=	1	3919
4581	Locked	=	12	3921
4587	Raining	=	20	3925
4590	Locked	=	12	3928
4591	On	=	1	3929
4592	 	=	72	3930
4593	Open	=	13	3931
4594	80	<	18	3932
4595	60	>	18	3933
4596	Not Raining	=	20	3934
4597	Open	=	65	3935
4598	Pop	=	8	3936
4599	Asleep	=	68	3937
4600	Unlocked	=	12	3938
4601	40	>	75	3939
4602	40	<	75	3940
4603	80	>	21	3941
4604	80	>	21	3942
4605	73	=	21	3943
4606	Home	 	70	3944
4607	Anyone	 	71	3944
4608	70	<	21	3945
4609	Home	 	70	3946
4610	Nobody	 	71	3946
4611	80	>	21	3947
4612	40	<	75	3948
4613	45	>	75	3949
4614	40	<	75	3950
4615	80	=	21	3951
4616	Home	=	70	3952
4617	Anyone	=	71	3952
4618	72	=	21	3953
4619	80	>	21	3954
4620	40	=	75	3955
4621	80	>	21	3956
4622	Pop	=	8	3957
4623	Pop	=	8	3958
4624	Open	=	13	3959
4625	Raining	=	20	3960
4626	Open	=	13	3961
4627	Raining	=	20	3962
4628	Not Raining	=	20	3963
4629	Open	=	13	3964
4630	Open	=	13	3965
4631	Raining	=	20	3966
4632	Open	=	13	3967
4633	Raining	=	20	3968
4634	On	=	1	3969
4635	Raining	=	20	3970
4636	Open	=	13	3971
4637	Open	=	13	3972
4638	Raining	=	20	3973
4639	Open	=	13	3974
4640	Not Raining	=	20	3975
4641	Raining	=	20	3976
4642	Open	=	13	3977
4643	Open	=	13	3978
4644	Raining	=	20	3979
4645	Open	=	13	3980
4646	Raining	=	20	3981
4647	Raining	=	20	3982
4648	Open	=	13	3983
4649	Open	=	13	3984
4650	Raining	=	20	3985
4651	Raining	=	20	3986
4652	Open	=	13	3987
4653	Closed	=	13	3988
4654	Closed	=	13	3989
4655	Closed	=	13	3990
4656	Closed	=	13	3991
4657	Closed	=	13	3992
4658	Closed	=	13	3993
4659	80	<	21	3994
4660	Closed	=	13	3995
4661	Closed	=	13	3996
4662	Closed	=	13	3997
4663	Closed	=	13	3998
4664	Closed	=	13	3999
4665	Closed	=	13	4000
4666	Closed	=	13	4001
4667	Closed	=	13	4002
4668	Closed	=	13	4003
4669	Closed	=	13	4004
4670	Open	=	13	4005
4671	Closed	=	13	4006
4672	Closed	=	13	4007
4673	Closed	=	13	4008
4674	Closed	=	13	4009
4675	Closed	=	13	4010
4676	Closed	=	13	4011
4677	Closed	=	13	4012
4678	Closed	=	13	4013
4679	Closed	=	13	4014
4680	Closed	=	13	4015
4681	Closed	=	13	4016
4682	Closed	=	13	4017
4683	Closed	=	13	4018
4684	Closed	=	13	4019
4685	Closed	=	13	4020
4686	Closed	=	13	4021
4687	Closed	=	13	4022
4688	Closed	=	13	4023
4689	Closed	=	13	4024
4690	Closed	=	13	4025
4691	Closed	=	13	4026
4692	Closed	=	13	4027
4693	Closed	=	13	4028
4694	Closed	=	13	4029
4695	Closed	=	13	4030
4696	Closed	=	13	4031
4697	Closed	=	13	4032
4698	80	>	21	4033
4699	85	>	21	4034
4700	80	>	21	4035
4701	80	>	21	4036
4702	On	=	1	4037
4703	80	>	21	4038
4704	80	>	21	4039
4705	Open	=	67	4040
4706	{'parameters': [{'type': 'bin', 'id': 67, 'values': ['Open', 'Closed'], 'name': 'position'}], 'device': {'id': 8, 'name': 'Smart Refrigerator'}, 'capability': {'label': "{DEVICE}'s door is {position}", 'id': 60, 'name': 'Open/Close Door'}, 'parameterVals': [{'value': 'Closed', 'comparator': '='}], 'channel': {'id': 13, 'icon': 'fastfood', 'name': 'Food & Cooking'}, 'text': "Smart Refrigerator's door is Closed"}	=	55	4041
4707	{'seconds': 120, 'minutes': 0, 'hours': 0}	>	56	4041
4708	Open	=	67	4042
4832	80	<	18	4144
4833	Open	=	13	4145
4834	Closed	=	13	4146
4835	Closed	=	13	4147
4709	{'parameters': [{'type': 'bin', 'id': 67, 'values': ['Open', 'Closed'], 'name': 'position'}], 'device': {'id': 8, 'name': 'Smart Refrigerator'}, 'capability': {'label': "{DEVICE}'s door is {position}", 'id': 60, 'name': 'Open/Close Door'}, 'parameterVals': [{'value': 'Closed', 'comparator': '='}], 'channel': {'id': 13, 'icon': 'fastfood', 'name': 'Food & Cooking'}, 'text': "Smart Refrigerator's door is Closed"}	=	55	4043
4710	{'seconds': 60, 'minutes': 0, 'hours': 0}	>	56	4043
4711	Kitchen	 	70	4044
4712	Alice	 	71	4044
4713	Open	=	13	4045
4714	60	>	18	4046
4715	80	<	18	4047
4716	Not Raining	=	20	4048
4717	70	>	18	4049
4718	80	<	18	4050
4719	Closed	=	13	4051
4720	Not Raining	=	20	4052
4721	Not Raining	=	20	4053
4722	60	>	18	4054
4723	80	<	18	4055
4724	Closed	=	13	4056
4725	Closed	=	13	4057
4726	Not Raining	=	20	4058
4727	60	>	18	4059
4728	80	<	18	4060
4729	Open	=	13	4061
4730	60	>	18	4062
4731	80	<	18	4063
4732	Not Raining	=	20	4064
4733	Not Raining	=	20	4065
4734	60	>	18	4066
4735	80	<	18	4067
4736	Closed	=	13	4068
4737	Closed	=	13	4069
4738	Not Raining	=	20	4070
4739	60	>	18	4071
4740	80	<	18	4072
4741	75	<	21	4073
4742	Home	 	70	4074
4743	A Family Member	 	71	4074
4744	70	>	21	4075
4745	Home	 	70	4076
4746	A Family Member	 	71	4076
4747	75	>	21	4077
4748	Home	 	70	4078
4749	A Family Member	 	71	4078
4750	75	>	21	4079
4751	Home	 	70	4080
4752	A Family Member	 	71	4080
4753	70	=	21	4081
4754	Home	 	70	4082
4755	A Family Member	 	71	4082
4756	75	=	21	4083
4757	Home	 	70	4084
4758	A Family Member	 	71	4084
4759	75	<	21	4085
4760	Home	 	70	4086
4761	A Family Member	 	71	4086
4762	70	>	21	4087
4763	Home	 	70	4088
4764	A Family Member	 	71	4088
4765	70	<	21	4089
4766	Home	 	70	4090
4767	A Family Member	 	71	4090
4768	75	>	21	4091
4769	Home	 	70	4092
4770	A Family Member	 	71	4092
4771	70	=	21	4093
4772	Home	 	70	4094
4773	A Family Member	 	71	4094
4774	75	=	21	4095
4775	Home	 	70	4096
4776	A Family Member	 	71	4096
4777	Home	=	70	4097
4778	A Family Member	=	71	4097
4779	75	>	21	4098
4780	Home	=	70	4099
4781	A Family Member	=	71	4099
4782	70	<	21	4100
4783	Home	=	70	4101
4784	A Family Member	=	71	4101
4785	70	=	21	4102
4786	Open	=	65	4103
4787	Open	=	65	4104
4788	On	=	1	4105
4789	Open	=	65	4106
4790	Open	=	65	4107
4791	Open	=	65	4108
4792	Open	=	65	4109
4793	Unlocked	=	12	4110
4794	Asleep	=	68	4111
4795	Unlocked	=	12	4112
4796	Off	=	1	4113
4797	Unlocked	=	12	4114
4798	Asleep	=	68	4115
4799	Unlocked	=	12	4116
4800	Asleep	=	68	4117
4801	Unlocked	=	12	4118
4802	Asleep	=	68	4119
4803	Unlocked	=	12	4120
4804	Asleep	=	68	4121
4805	On	=	1	4122
4806	On	=	1	4123
4807	Home	=	70	4124
4808	A Guest	=	71	4124
4809	On	=	1	4125
4810	{'parameters': [{'type': 'set', 'id': 70, 'values': ['Home', 'Kitchen', 'Bedroom', 'Bathroom', 'Living Room'], 'name': 'location'}, {'type': 'set', 'id': 71, 'values': ['Anyone', 'Alice', 'Bobbie', 'A Family Member', 'A Guest', 'Nobody'], 'name': 'who'}], 'device': {'id': 12, 'name': 'Location Sensor'}, 'capability': {'label': '{who/=|}{who/!=|Someone other than }{who} {location/=|Enters}{location/!=|Exits} {location}', 'id': 63, 'name': 'Detect Presence'}, 'parameterVals': [{'value': 'Home', 'comparator': '='}, {'value': 'A Guest', 'comparator': '='}], 'channel': {'id': 15, 'icon': 'room', 'name': 'Location'}, 'text': 'A Guest Enters Home'}	=	57	4126
4811	{'seconds': 0, 'minutes': 0, 'hours': 2}	<	58	4126
4812	Off	=	1	4127
4813	Asleep	=	68	4128
4814	{'parameters': [{'type': 'bin', 'id': 68, 'values': ['Awake', 'Asleep'], 'name': 'status'}], 'device': {'id': 21, 'name': 'FitBit'}, 'capability': {'label': '({DEVICE}) I {status/T|Wake Up}{status/F|Fall Asleep}', 'id': 61, 'name': 'Sleep Sensor'}, 'parameterVals': [{'value': 'Asleep', 'comparator': '='}], 'channel': {'id': 16, 'icon': 'favorite_border', 'name': 'Health'}, 'text': '(FitBit) I Fall Asleep'}	=	57	4129
4815	{'seconds': 0, 'minutes': 30, 'hours': 0}	>	58	4129
4816	On	=	1	4130
4817	On	=	1	4131
4818	70	>	21	4132
4819	Home	 	70	4133
4820	A Family Member	 	71	4133
4821	75	<	21	4134
4822	Home	 	70	4135
4823	A Family Member	 	71	4135
4824	Open	=	13	4136
4825	60	>	18	4137
4826	80	<	18	4138
4827	Not Raining	=	20	4139
4828	Open	=	13	4140
4829	Raining	=	20	4141
4830	60	>	18	4142
4831	Open	=	13	4143
4836	Closed	=	13	4148
4837	Open	=	13	4149
4838	60	>	18	4150
4839	80	<	18	4151
4840	Not Raining	=	20	4152
4841	On	=	1	4153
4842	Home	=	70	4154
4843	A Guest	=	71	4154
4844	On	=	1	4155
4845	Open	=	65	4156
4846	Open	=	13	4157
4847	Closed	=	13	4158
4848	On	=	64	4159
4849	Closed	=	13	4160
4850	Raining	=	20	4161
4851	Open	=	13	4162
4852	Off	=	1	4163
4853	Asleep	=	68	4164
4854	Off	=	1	4165
4855	Asleep	=	68	4166
\.


--
-- Name: backend_condition_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backend_condition_id_seq', 4855, true);


--
-- Data for Name: backend_device; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backend_device (id, name, owner_id, public, icon) FROM stdin;
7	Speakers	1	t	speaker
5	Smart TV	1	t	tv
21	FitBit	1	t	watch
9	Coffee Pot	1	t	local_cafe
12	Location Sensor	1	t	pin_drop
10	Security Camera	1	t	videocam
11	Device Tracker	1	t	history
6	Smart Plug	1	t	power
1	Roomba	1	t	room_service
8	Smart Refrigerator	1	t	kitchen
18	Weather Sensor	1	t	wb_cloudy
19	Smoke Detector	1	t	disc_full
3	Amazon Echo	1	t	assistant
17	Clock	1	t	access_alarm
22	Smart Faucet	1	t	waves
2	Thermostat	1	t	brightness_medium
4	HUE Lights	1	t	highlight
23	Smart Oven	1	t	\N
24	Bathroom Window	1	t	\N
25	Living Room Window	1	t	\N
14	Bedroom Window	1	t	crop_original
13	Front Door Lock	1	t	lock
20	Power Main	1	f	power
\.


--
-- Name: backend_device_capabilities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backend_device_capabilities_id_seq', 88, true);


--
-- Data for Name: backend_device_caps; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backend_device_caps (id, device_id, capability_id) FROM stdin;
7	1	2
8	2	19
9	2	21
10	3	32
11	3	33
13	3	35
14	3	8
15	3	9
16	3	12
23	3	30
24	3	31
26	4	2
27	4	3
28	4	6
29	5	8
30	5	2
31	5	36
32	5	37
33	6	2
34	7	8
35	7	9
36	7	2
37	7	35
38	7	12
39	8	33
41	9	2
42	9	38
43	9	39
44	10	28
45	10	29
46	10	15
47	10	40
52	11	49
53	11	50
54	11	51
55	11	52
57	13	13
58	14	13
59	14	14
60	17	25
61	17	26
62	17	27
63	17	55
64	3	56
65	7	56
66	10	2
67	18	18
68	18	19
69	18	20
70	2	57
71	14	58
72	19	59
73	20	2
74	8	60
75	21	61
76	21	62
77	12	63
78	22	64
79	23	2
80	23	60
81	23	65
82	8	19
83	8	66
84	24	58
85	24	14
86	25	58
87	25	14
88	23	13
\.


--
-- Data for Name: backend_device_chans; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backend_device_chans (id, device_id, channel_id) FROM stdin;
1	1	1
2	2	8
3	3	1
4	3	3
5	3	6
6	3	7
7	3	8
8	3	9
9	3	11
10	3	13
11	4	1
12	4	2
13	5	1
14	5	12
15	6	1
16	7	1
17	7	3
18	8	13
19	8	11
20	9	13
21	10	4
22	10	1
23	10	10
24	10	6
25	12	6
26	13	4
27	14	4
28	14	5
29	11	14
30	17	9
31	9	1
32	12	15
33	18	8
34	18	6
35	18	7
36	19	6
37	20	1
38	21	16
39	21	6
40	22	17
41	22	13
42	23	13
43	1	18
44	24	5
45	25	5
46	13	5
\.


--
-- Name: backend_device_chans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backend_device_chans_id_seq', 46, true);


--
-- Name: backend_device_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backend_device_id_seq', 25, true);


--
-- Data for Name: backend_durationparam; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backend_durationparam (parameter_ptr_id, maxhours, maxmins, maxsecs, comp) FROM stdin;
51	23	59	59	f
53	23	59	59	f
56	23	59	59	t
58	23	59	59	t
\.


--
-- Data for Name: backend_esrule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backend_esrule (action_id, "Etrigger_id", rule_ptr_id) FROM stdin;
44	219	35
46	223	37
47	226	38
48	229	39
49	232	40
50	234	41
51	236	42
52	237	43
53	238	44
54	239	45
55	240	46
56	244	47
57	248	48
58	252	49
404	1591	365
856	2821	771
857	2822	772
858	2826	773
859	2827	774
860	2831	775
861	2834	776
862	2837	777
863	2840	778
864	2842	779
866	2846	780
867	2848	781
869	2856	782
873	2868	785
874	2871	783
875	2874	786
876	2880	787
877	2884	788
878	2885	789
880	2914	791
881	2915	790
882	2918	792
883	2922	793
884	2931	794
885	2933	795
886	2936	796
887	2957	797
888	2958	798
889	2960	799
890	2963	800
891	2967	801
892	2985	802
894	2992	804
896	3004	805
897	3005	806
898	3007	807
899	3008	803
900	3018	808
901	3026	809
903	3029	810
904	3033	811
905	3035	812
906	3040	813
907	3042	814
908	3046	815
909	3047	816
910	3067	817
912	3077	819
913	3085	820
915	3092	822
917	3104	824
919	3116	826
922	3124	828
923	3125	829
925	3128	831
929	3143	835
930	3155	825
931	3158	836
932	3162	837
933	3166	838
934	3169	839
935	3172	830
936	3175	840
940	3183	842
941	3185	843
945	3195	846
947	3200	848
948	3210	849
949	3211	850
950	3214	851
951	3216	852
952	3217	853
953	3219	854
955	3225	856
956	3226	857
957	3229	858
958	3233	859
961	3244	862
962	3246	863
963	3247	864
964	3248	865
965	3252	866
966	3253	867
967	3258	868
968	3260	869
969	3264	870
971	3272	872
974	3279	875
975	3280	876
976	3282	877
977	3284	878
980	3301	881
981	3302	882
982	3309	883
983	3311	884
987	3320	888
988	3323	889
989	3328	890
990	3330	891
991	3335	892
993	3338	894
994	3340	895
995	3344	896
997	3347	898
998	3351	899
999	3354	900
1001	3363	902
1003	3366	904
1004	3374	905
1005	3376	906
1008	3389	909
1011	3408	910
1012	3419	911
1013	3425	912
1016	3430	914
1017	3432	915
1018	3439	916
1020	3448	918
1021	3450	919
1022	3456	920
1023	3463	917
1024	3473	921
1025	3491	922
1028	3503	924
1030	3510	926
1031	3519	925
1032	3530	927
1034	3539	929
1035	3540	930
1037	3548	931
1038	3549	932
1039	3550	933
1040	3551	934
1045	3561	936
1047	3563	937
1049	3570	939
1051	3573	941
1052	3576	942
1055	3589	945
1057	3593	943
1058	3596	944
1062	3609	949
1063	3616	950
1066	3620	951
1068	3624	952
1069	3625	953
1071	3629	954
1072	3635	955
1073	3637	956
1074	3638	957
1075	3643	958
1077	3650	960
1078	3651	961
1079	3652	959
1080	3653	962
1082	3656	964
1085	3659	965
1087	3662	966
1088	3666	967
1089	3671	968
1091	3674	969
1092	3675	970
1093	3680	971
1094	3682	972
1095	3683	973
1096	3685	974
1098	3687	976
1099	3689	977
1100	3693	978
1101	3695	979
1102	3698	980
1103	3699	975
1104	3703	981
1106	3706	983
1107	3711	984
1108	3713	985
1109	3715	986
1110	3716	987
1111	3718	988
1112	3721	989
1113	3723	990
1115	3725	992
1117	3731	994
1118	3732	995
1119	3734	996
1120	3735	997
1121	3737	993
1122	3740	998
1123	3741	999
1124	3742	1000
1125	3743	1001
1126	3744	1002
1127	3746	1003
1128	3747	1004
1129	3750	1005
1130	3751	1006
1131	3752	1007
1133	3767	1009
1135	3769	1010
1136	3770	1011
1137	3772	1012
1140	3777	1014
1141	3778	1015
1143	3782	1017
1144	3784	1018
1145	3785	1019
1147	3788	1021
1148	3790	1022
1149	3791	1023
1150	3792	1024
1151	3794	1025
1152	3795	1026
1153	3796	1027
1154	3797	1028
1155	3798	1029
1157	3801	1031
1158	3803	1030
1159	3805	1032
1160	3810	1033
1161	3811	1034
1162	3814	1035
1163	3815	1036
1164	3817	1037
1165	3819	1038
1167	3831	1039
1168	3835	1040
1169	3838	1041
1170	3840	1042
1171	3845	1043
1173	3847	1045
1174	3850	1046
1177	3858	1049
1178	3860	1050
1180	3863	1051
1181	3865	1052
1183	3869	1053
1184	3871	1054
1185	3873	1055
1186	3874	1056
1187	3875	1057
1188	3877	1058
1189	3880	1059
1190	3883	1060
1191	3886	1061
1192	3889	1062
1194	3896	1063
1195	3902	1064
1197	3909	1065
1198	3910	1066
1199	3911	1067
1200	3914	1068
1201	3915	1069
1202	3918	1070
1203	3919	1071
1206	3925	1074
1207	3961	1075
1208	3963	1076
1209	3967	1077
1210	3970	1078
1211	3974	1079
1212	3976	1080
1213	3980	1081
1214	3982	1082
1215	3986	1083
1216	3991	1084
1217	3995	1085
1218	3998	1086
1219	4004	1087
1220	4006	1088
1221	4009	1089
1222	4015	1090
1223	4018	1091
1224	4021	1092
1225	4027	1093
1226	4030	1094
1227	4034	1095
1228	4036	1096
1229	4039	1097
1230	4041	1098
1231	4043	1099
1232	4049	1100
1233	4053	1101
1234	4057	1102
1235	4065	1103
1236	4069	1104
1237	4077	1105
1238	4079	1106
1239	4081	1107
1240	4083	1108
1241	4089	1109
1242	4091	1110
1243	4093	1111
1244	4095	1112
1245	4097	1113
1246	4099	1114
1247	4101	1115
1248	4104	1116
1249	4107	1117
1250	4109	1118
1251	4112	1119
1252	4116	1120
1253	4120	1121
1254	4125	1122
1255	4129	1123
\.


--
-- Data for Name: backend_esrule_Striggers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."backend_esrule_Striggers" (id, esrule_id, trigger_id) FROM stdin;
7	35	220
9	37	224
10	37	225
11	38	227
12	38	228
13	39	230
14	39	231
15	40	233
16	41	235
17	46	241
18	46	242
19	46	243
20	47	245
21	47	246
22	47	247
23	48	249
24	48	250
25	48	251
26	49	253
27	49	254
28	49	255
277	365	1592
528	774	2828
529	775	2832
530	776	2835
531	777	2838
532	778	2841
533	779	2843
536	782	2857
537	782	2858
540	785	2869
541	785	2870
542	783	2872
543	783	2873
544	786	2875
545	796	2937
546	798	2959
547	800	2964
548	801	2968
549	802	2986
552	804	2993
553	804	2994
556	803	3009
557	808	3019
558	808	3020
560	810	3030
561	811	3034
562	813	3041
563	817	3068
568	819	3078
569	819	3079
570	820	3086
572	824	3105
578	831	3129
579	831	3130
580	831	3131
582	835	3144
583	835	3145
584	835	3146
585	825	3156
586	825	3157
587	836	3159
588	836	3160
589	837	3163
590	839	3170
591	839	3171
592	830	3173
593	830	3174
594	840	3176
595	840	3177
598	842	3184
599	843	3186
602	846	3196
603	848	3201
604	848	3202
605	853	3218
606	854	3220
609	858	3230
611	862	3245
612	867	3254
613	867	3255
614	868	3259
615	870	3265
616	870	3266
620	876	3281
621	877	3283
622	882	3303
623	883	3310
624	884	3312
626	888	3321
627	889	3324
628	890	3329
629	891	3331
631	894	3339
632	896	3345
633	898	3348
634	900	3355
635	902	3364
636	904	3367
637	905	3375
638	906	3377
641	909	3390
642	909	3391
645	910	3409
646	912	3426
648	914	3431
649	915	3433
650	916	3440
653	918	3449
654	920	3457
655	917	3464
656	917	3465
657	921	3474
658	921	3475
659	922	3492
660	922	3493
663	924	3504
664	924	3505
666	926	3511
667	926	3512
668	925	3520
669	925	3521
670	927	3531
671	927	3532
679	941	3574
680	942	3577
681	945	3590
682	945	3591
683	943	3594
684	943	3595
685	944	3597
686	944	3598
687	949	3610
688	949	3611
689	949	3612
690	949	3613
691	955	3636
692	957	3639
693	958	3644
694	965	3660
695	966	3663
696	967	3667
697	968	3672
698	970	3676
699	970	3677
700	971	3681
701	973	3684
702	976	3688
703	977	3690
704	978	3694
705	979	3696
706	979	3697
707	981	3704
708	983	3707
709	983	3708
710	984	3712
711	985	3714
712	987	3717
713	988	3719
714	988	3720
715	989	3722
718	995	3733
719	997	3736
720	993	3738
721	993	3739
722	1002	3745
723	1004	3748
724	1004	3749
725	1011	3771
726	1017	3783
729	1031	3802
730	1030	3804
731	1032	3806
732	1032	3807
733	1032	3808
734	1032	3809
735	1034	3812
736	1034	3813
737	1036	3816
738	1037	3818
739	1038	3820
740	1038	3821
741	1038	3822
745	1039	3832
746	1039	3833
747	1039	3834
748	1040	3836
749	1041	3839
750	1042	3841
752	1049	3859
753	1050	3861
754	1051	3864
755	1052	3866
757	1053	3870
758	1054	3872
759	1057	3876
760	1060	3884
761	1060	3885
762	1061	3887
763	1061	3888
764	1062	3890
765	1062	3891
766	1063	3897
767	1064	3903
768	1067	3912
769	1067	3913
770	1069	3916
771	1069	3917
773	1075	3962
774	1076	3964
775	1077	3968
776	1077	3969
777	1078	3971
778	1079	3975
779	1080	3977
780	1081	3981
781	1082	3983
782	1083	3987
783	1084	3992
784	1084	3993
785	1084	3994
786	1085	3996
787	1085	3997
788	1086	3999
789	1086	4000
790	1087	4005
791	1088	4007
792	1088	4008
793	1089	4010
794	1089	4011
795	1090	4016
796	1090	4017
797	1091	4019
798	1091	4020
799	1092	4022
800	1092	4023
801	1093	4028
802	1093	4029
803	1094	4031
804	1094	4032
805	1096	4037
806	1099	4044
807	1100	4050
808	1100	4051
809	1100	4052
810	1101	4054
811	1101	4055
812	1101	4056
813	1102	4058
814	1102	4059
815	1102	4060
816	1103	4066
817	1103	4067
818	1103	4068
819	1104	4070
820	1104	4071
821	1104	4072
822	1105	4078
823	1106	4080
824	1107	4082
825	1108	4084
826	1109	4090
827	1110	4092
828	1111	4094
829	1112	4096
830	1113	4098
831	1114	4100
832	1115	4102
833	1116	4105
834	1119	4113
835	1120	4117
836	1121	4121
837	1121	4122
838	1122	4126
839	1123	4130
840	1123	4131
\.


--
-- Name: backend_esrule_triggersS_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."backend_esrule_triggersS_id_seq"', 840, true);


--
-- Data for Name: backend_inputparam; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backend_inputparam (parameter_ptr_id, inputtype) FROM stdin;
27	stxt
28	int
31	int
32	stxt
34	stxt
35	stxt
37	stxt
\.


--
-- Data for Name: backend_metaparam; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backend_metaparam (parameter_ptr_id, is_event) FROM stdin;
50	f
52	t
55	f
57	t
\.


--
-- Data for Name: backend_parameter; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backend_parameter (id, name, type, cap_id) FROM stdin;
3	color	set	6
17	weather	set	18
11	frequency	range	12
24	time	time	26
25	value	bin	27
26	value	bin	28
28	quantity	input	30
30	topping	set	31
31	quantity	input	31
33	distance	range	32
34	item	input	33
35	name	input	35
36	channel	range	36
37	name	input	37
39	cups	range	39
40	value	bin	40
50	trigger	meta	49
51	time	duration	49
52	trigger	meta	50
53	time	duration	50
54	occurrences	range	50
55	trigger	meta	51
56	time	duration	51
57	trigger	meta	52
58	time	duration	52
69	BPM	range	62
71	who	set	63
27	item	input	30
73	cups	range	38
74	temperature	range	65
18	temperature	range	19
21	temperature	range	21
29	size	set	31
75	temperature	range	66
70	location	set	63
32	trackingid	input	32
1	setting	bin	2
2	level	range	3
7	level	range	8
8	genre	set	9
12	setting	bin	13
13	position	bin	14
20	condition	bin	20
23	time	time	25
14	status	bin	15
62	time	bin	55
64	setting	bin	57
65	position	bin	58
66	condition	bin	59
67	position	bin	60
68	status	bin	61
72	setting	bin	64
\.


--
-- Name: backend_parameter_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backend_parameter_id_seq', 76, true);


--
-- Data for Name: backend_parval; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backend_parval (id, val, par_id, state_id) FROM stdin;
\.


--
-- Name: backend_parval_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backend_parval_id_seq', 1, false);


--
-- Data for Name: backend_rangeparam; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backend_rangeparam (parameter_ptr_id, min, max, "interval") FROM stdin;
2	1	5	1
7	0	100	1
11	88	108	0.100000000000000006
18	-50	120	1
21	60	90	1
33	1	250	1
36	0	2000	1
39	1	5	1
54	0	25	1
69	40	220	5
73	0	5	1
74	0	600	5
75	20	60	1
\.


--
-- Data for Name: backend_rule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backend_rule (id, owner_id, type, task, lastedit) FROM stdin;
35	1	es	1	2018-08-10 01:23:22.79171+00
37	1	es	2	2018-08-10 01:28:00.997979+00
38	1	es	2	2018-08-10 01:29:23.921173+00
39	1	es	2	2018-08-10 01:30:40.190673+00
40	1	es	3	2018-08-10 01:32:00.349084+00
41	1	es	3	2018-08-10 01:32:55.219512+00
42	1	es	4	2018-08-10 03:02:53.507562+00
43	1	es	5	2018-08-10 03:04:30.382947+00
44	1	es	6	2018-08-10 03:15:31.818393+00
45	1	es	7	2018-08-10 03:30:14.19687+00
46	1	es	8	2018-08-10 03:34:40.717071+00
47	1	es	8	2018-08-10 03:36:20.640195+00
48	1	es	8	2018-08-10 03:37:45.473294+00
49	1	es	8	2018-08-10 03:58:35.799463+00
365	1	es	1	2018-08-19 21:07:56.281145+00
771	156	es	3	2018-08-20 23:29:55.093668+00
772	158	es	12	2018-08-20 23:31:15.38548+00
773	156	es	5	2018-08-20 23:34:07.233598+00
774	158	es	16	2018-08-20 23:35:02.365515+00
775	158	es	2	2018-08-20 23:38:39.24433+00
776	158	es	2	2018-08-20 23:39:28.11851+00
777	158	es	2	2018-08-20 23:40:27.665606+00
778	156	es	16	2018-08-20 23:42:05.153782+00
779	158	es	3	2018-08-20 23:43:57.373175+00
780	156	es	4	2018-08-20 23:45:41.247805+00
781	158	es	7	2018-08-20 23:49:29.890147+00
782	156	es	2	2018-08-20 23:52:13.502573+00
785	156	es	2	2018-08-20 23:53:58.643546+00
783	156	es	2	2018-08-20 23:54:37.994796+00
786	158	es	10	2018-08-20 23:54:54.20472+00
787	156	es	15	2018-08-20 23:59:09.840484+00
788	158	es	11	2018-08-21 00:01:05.185579+00
789	156	es	14	2018-08-21 00:02:02.054888+00
791	164	es	8	2018-08-21 00:19:05.259276+00
790	164	es	8	2018-08-21 00:19:47.635109+00
792	165	es	11	2018-08-21 00:20:06.972277+00
793	164	es	8	2018-08-21 00:22:43.567113+00
794	165	es	7	2018-08-21 00:27:02.374965+00
795	164	es	11	2018-08-21 00:28:55.625123+00
796	165	es	7	2018-08-21 00:30:48.840991+00
797	164	es	5	2018-08-21 00:34:36.054657+00
798	165	es	12	2018-08-21 00:35:15.433692+00
799	164	es	5	2018-08-21 00:35:41.97016+00
800	165	es	3	2018-08-21 00:38:01.818357+00
801	165	es	3	2018-08-21 00:38:46.062802+00
802	165	es	16	2018-08-21 00:44:47.559034+00
804	165	es	16	2018-08-21 00:47:11.460083+00
814	164	es	10	2018-08-21 01:18:43.330128+00
805	167	es	12	2018-08-21 00:48:13.875998+00
806	165	es	10	2018-08-21 00:48:33.183549+00
807	165	es	5	2018-08-21 00:51:32.392938+00
803	164	es	15	2018-08-21 00:52:25.219983+00
808	167	es	8	2018-08-21 00:59:37.66756+00
809	164	es	6	2018-08-21 01:07:12.296422+00
810	167	es	7	2018-08-21 01:08:54.930061+00
811	167	es	3	2018-08-21 01:12:51.398642+00
812	164	es	12	2018-08-21 01:13:00.643722+00
813	167	es	6	2018-08-21 01:17:02.354084+00
815	167	es	11	2018-08-21 01:20:49.840178+00
816	167	es	16	2018-08-21 01:23:26.493544+00
817	171	es	14	2018-08-21 01:37:43.431541+00
819	171	es	6	2018-08-21 01:47:33.550548+00
820	171	es	7	2018-08-21 01:49:49.46201+00
822	171	es	11	2018-08-21 01:52:45.893911+00
824	171	es	15	2018-08-21 02:01:48.855859+00
826	171	es	10	2018-08-21 02:03:57.199821+00
836	180	es	2	2018-08-21 02:09:41.14006+00
828	179	es	11	2018-08-21 02:05:22.03426+00
829	171	es	4	2018-08-21 02:05:23.490573+00
831	176	es	12	2018-08-21 02:06:02.753178+00
835	178	es	2	2018-08-21 02:08:06.979351+00
825	178	es	2	2018-08-21 02:09:33.23131+00
837	178	es	2	2018-08-21 02:10:11.761464+00
838	176	es	4	2018-08-21 02:10:28.348643+00
839	180	es	2	2018-08-21 02:10:35.250272+00
830	178	es	2	2018-08-21 02:11:14.651146+00
840	180	es	2	2018-08-21 02:11:27.210835+00
959	209	es	8	2018-08-21 03:56:22.376193+00
842	185	es	9	2018-08-21 02:12:48.128993+00
843	178	es	12	2018-08-21 02:13:06.171232+00
846	185	es	14	2018-08-21 02:15:17.066309+00
848	178	es	16	2018-08-21 02:16:09.915961+00
849	188	es	6	2018-08-21 02:16:52.736513+00
850	186	es	11	2018-08-21 02:16:57.917683+00
851	185	es	10	2018-08-21 02:17:08.310819+00
852	176	es	9	2018-08-21 02:18:06.266049+00
853	180	es	7	2018-08-21 02:18:16.951324+00
854	179	es	7	2018-08-21 02:18:22.888655+00
856	185	es	3	2018-08-21 02:20:37.667493+00
857	188	es	11	2018-08-21 02:20:40.545489+00
858	178	es	9	2018-08-21 02:21:02.058459+00
859	176	es	9	2018-08-21 02:21:39.572509+00
862	185	es	12	2018-08-21 02:22:58.447697+00
863	188	es	3	2018-08-21 02:23:06.644496+00
864	186	es	10	2018-08-21 02:23:13.996153+00
865	179	es	5	2018-08-21 02:23:19.018847+00
866	176	es	10	2018-08-21 02:23:48.598105+00
867	180	es	3	2018-08-21 02:23:56.487246+00
868	178	es	15	2018-08-21 02:24:39.737831+00
869	185	es	4	2018-08-21 02:25:10.045991+00
870	180	es	3	2018-08-21 02:25:28.466451+00
872	186	es	14	2018-08-21 02:26:29.397622+00
875	176	es	14	2018-08-21 02:27:32.321439+00
876	185	es	2	2018-08-21 02:27:35.714049+00
877	178	es	11	2018-08-21 02:27:40.636148+00
878	179	es	9	2018-08-21 02:28:15.14946+00
881	176	es	7	2018-08-21 02:31:22.059492+00
882	180	es	3	2018-08-21 02:31:24.999634+00
883	188	es	12	2018-08-21 02:32:44.594776+00
884	179	es	8	2018-08-21 02:33:08.58364+00
888	179	es	8	2018-08-21 02:34:25.466916+00
889	176	es	2	2018-08-21 02:34:41.085524+00
890	176	es	2	2018-08-21 02:35:15.704214+00
891	180	es	8	2018-08-21 02:35:16.95487+00
892	179	es	8	2018-08-21 02:35:33.125104+00
894	180	es	8	2018-08-21 02:35:56.8847+00
895	186	es	14	2018-08-21 02:35:58.051933+00
896	176	es	2	2018-08-21 02:36:24.013907+00
898	180	es	8	2018-08-21 02:36:31.912142+00
899	179	es	8	2018-08-21 02:36:34.915013+00
900	188	es	9	2018-08-21 02:36:59.417974+00
902	180	es	8	2018-08-21 02:39:42.010409+00
904	180	es	8	2018-08-21 02:40:24.245813+00
905	188	es	10	2018-08-21 02:40:59.960994+00
906	180	es	8	2018-08-21 02:41:13.693477+00
909	179	es	16	2018-08-21 02:42:26.119449+00
962	209	es	8	2018-08-21 03:57:00.514333+00
910	180	es	6	2018-08-21 02:47:41.686199+00
911	199	es	5	2018-08-21 02:48:46.799506+00
912	179	es	12	2018-08-21 02:49:20.548067+00
914	179	es	12	2018-08-21 02:50:04.830189+00
915	179	es	12	2018-08-21 02:50:53.617627+00
916	179	es	12	2018-08-21 02:51:47.457441+00
918	179	es	12	2018-08-21 02:52:43.099067+00
919	180	es	4	2018-08-21 02:52:58.877665+00
920	179	es	12	2018-08-21 02:53:31.19123+00
917	180	es	4	2018-08-21 02:54:14.20197+00
921	180	es	4	2018-08-21 02:55:40.945715+00
922	199	es	2	2018-08-21 02:57:43.260016+00
924	199	es	2	2018-08-21 02:59:33.438723+00
926	199	es	2	2018-08-21 03:00:21.720389+00
925	180	es	16	2018-08-21 03:02:02.733262+00
927	188	es	15	2018-08-21 03:03:25.578118+00
929	199	es	14	2018-08-21 03:07:14.421929+00
930	186	es	15	2018-08-21 03:07:56.549526+00
931	186	es	15	2018-08-21 03:12:07.208106+00
932	199	es	12	2018-08-21 03:12:25.262821+00
933	199	es	12	2018-08-21 03:12:45.37285+00
934	199	es	12	2018-08-21 03:13:07.420415+00
964	209	es	8	2018-08-21 03:57:34.901808+00
936	199	es	9	2018-08-21 03:19:27.400037+00
937	186	es	4	2018-08-21 03:23:40.816878+00
939	186	es	7	2018-08-21 03:29:21.784964+00
941	199	es	9	2018-08-21 03:35:01.150884+00
942	199	es	9	2018-08-21 03:35:46.619485+00
945	186	es	2	2018-08-21 03:41:54.100973+00
943	186	es	2	2018-08-21 03:42:28.169616+00
944	186	es	2	2018-08-21 03:42:55.758593+00
949	199	es	16	2018-08-21 03:46:29.063285+00
950	207	es	5	2018-08-21 03:46:39.691716+00
951	207	es	5	2018-08-21 03:48:10.753443+00
975	204	es	8	2018-08-21 04:06:28.268605+00
952	204	es	7	2018-08-21 03:49:03.281857+00
953	199	es	11	2018-08-21 03:49:31.29861+00
954	206	es	15	2018-08-21 03:51:28.479887+00
955	207	es	9	2018-08-21 03:51:59.940284+00
956	209	es	5	2018-08-21 03:52:33.746516+00
957	207	es	9	2018-08-21 03:52:47.262438+00
958	208	es	16	2018-08-21 03:54:30.978205+00
960	204	es	11	2018-08-21 03:55:50.358395+00
961	209	es	8	2018-08-21 03:55:57.929317+00
981	208	es	3	2018-08-21 04:07:46.912003+00
965	208	es	12	2018-08-21 03:58:45.660878+00
966	204	es	3	2018-08-21 03:59:02.232383+00
967	208	es	12	2018-08-21 03:59:27.000542+00
968	208	es	12	2018-08-21 03:59:58.632551+00
969	209	es	11	2018-08-21 04:00:49.276913+00
970	207	es	16	2018-08-21 04:02:04.260312+00
971	209	es	2	2018-08-21 04:03:19.767603+00
972	204	es	8	2018-08-21 04:04:04.343141+00
973	206	es	12	2018-08-21 04:04:07.698491+00
974	208	es	4	2018-08-21 04:04:39.834517+00
976	207	es	12	2018-08-21 04:04:52.521972+00
977	207	es	12	2018-08-21 04:05:20.711696+00
978	207	es	12	2018-08-21 04:05:47.381009+00
979	209	es	12	2018-08-21 04:05:52.711339+00
980	204	es	8	2018-08-21 04:06:05.20396+00
983	207	es	15	2018-08-21 04:09:54.948183+00
984	208	es	2	2018-08-21 04:10:55.878322+00
985	208	es	2	2018-08-21 04:11:21.650243+00
986	206	es	5	2018-08-21 04:11:32.757204+00
987	208	es	2	2018-08-21 04:11:48.714143+00
988	207	es	3	2018-08-21 04:13:05.671226+00
989	208	es	14	2018-08-21 04:13:43.51086+00
990	209	es	7	2018-08-21 04:13:53.08749+00
992	204	es	6	2018-08-21 04:14:36.852851+00
994	208	es	7	2018-08-21 04:16:29.870995+00
995	209	es	15	2018-08-21 04:17:28.700099+00
996	206	es	6	2018-08-21 04:18:44.269927+00
997	204	es	16	2018-08-21 04:19:32.980065+00
993	207	es	6	2018-08-21 04:20:58.698924+00
998	204	es	12	2018-08-21 04:23:09.706478+00
999	204	es	12	2018-08-21 04:23:32.237264+00
1000	204	es	12	2018-08-21 04:24:03.326194+00
1001	206	es	14	2018-08-21 04:24:05.811129+00
1002	206	es	14	2018-08-21 04:25:32.786982+00
1003	206	es	16	2018-08-21 04:34:48.799793+00
1004	206	es	2	2018-08-21 04:37:56.759217+00
1005	210	es	12	2018-08-21 04:43:49.957527+00
1006	210	es	12	2018-08-21 04:45:40.448926+00
1007	210	es	12	2018-08-21 04:46:28.255569+00
1009	210	es	7	2018-08-21 04:55:12.326364+00
1010	210	es	7	2018-08-21 04:56:34.387394+00
1011	210	es	7	2018-08-21 04:58:29.805835+00
1012	210	es	7	2018-08-21 05:00:13.410949+00
1014	210	es	4	2018-08-21 05:05:48.538809+00
1015	210	es	4	2018-08-21 05:06:51.286814+00
1017	210	es	16	2018-08-21 05:10:30.444054+00
1018	210	es	16	2018-08-21 05:11:48.07691+00
1019	210	es	16	2018-08-21 05:13:31.993381+00
1021	210	es	16	2018-08-21 05:14:40.864194+00
1022	210	es	2	2018-08-21 05:18:36.265475+00
1023	210	es	2	2018-08-21 05:19:10.950823+00
1024	210	es	2	2018-08-21 05:19:59.899998+00
1025	210	es	2	2018-08-21 05:21:57.890274+00
1026	210	es	9	2018-08-21 05:25:01.138243+00
1027	210	es	9	2018-08-21 05:25:56.595897+00
1028	210	es	9	2018-08-21 05:27:00.809624+00
1029	210	es	10	2018-08-21 05:30:37.92463+00
1031	210	es	10	2018-08-21 05:33:42.950235+00
1030	213	es	11	2018-08-21 05:34:08.299468+00
1032	213	es	12	2018-08-21 05:47:21.881038+00
1033	213	es	7	2018-08-21 05:52:20.640799+00
1034	213	es	3	2018-08-21 06:01:46.540023+00
1035	213	es	8	2018-08-21 06:03:33.311395+00
1036	213	es	16	2018-08-21 06:08:08.307223+00
1037	213	es	14	2018-08-21 06:09:59.186399+00
1038	214	es	2	2018-08-21 06:45:27.950954+00
1039	214	es	8	2018-08-21 06:58:19.501348+00
1040	214	es	12	2018-08-21 07:06:12.1928+00
1041	214	es	12	2018-08-21 07:09:52.837105+00
1042	214	es	12	2018-08-21 07:10:41.437825+00
1043	214	es	7	2018-08-21 07:16:05.230843+00
1045	214	es	11	2018-08-21 07:20:10.323449+00
1046	214	es	3	2018-08-21 07:22:59.599665+00
1049	214	es	9	2018-08-21 07:46:54.815018+00
1050	214	es	9	2018-08-21 07:49:33.146371+00
1051	214	es	9	2018-08-21 07:50:59.917786+00
1052	214	es	9	2018-08-21 07:53:08.778313+00
1053	214	es	9	2018-08-21 07:56:02.329573+00
1054	216	es	16	2018-08-21 08:04:03.186921+00
1055	216	es	15	2018-08-21 08:15:50.203427+00
1056	216	es	15	2018-08-21 08:16:51.694982+00
1057	216	es	3	2018-08-21 08:23:37.811448+00
1058	216	es	10	2018-08-21 08:27:17.425922+00
1059	216	es	4	2018-08-21 08:31:55.160632+00
1060	216	es	2	2018-08-21 08:36:25.934934+00
1061	216	es	2	2018-08-21 08:37:20.479075+00
1062	216	es	2	2018-08-21 08:38:04.41713+00
1063	216	es	14	2018-08-21 08:42:58.865327+00
1064	216	es	14	2018-08-21 08:43:30.58556+00
1065	218	es	5	2018-08-21 09:38:09.580085+00
1066	218	es	10	2018-08-21 09:42:50.809678+00
1067	218	es	10	2018-08-21 09:55:21.607731+00
1068	218	es	11	2018-08-21 09:58:15.83541+00
1069	218	es	6	2018-08-21 10:06:42.521487+00
1070	218	es	4	2018-08-21 10:10:32.847595+00
1071	218	es	4	2018-08-21 10:12:29.941424+00
1074	1	es	1	2018-10-08 21:14:58.601424+00
1075	222	es	1	2019-01-26 05:02:01.4436+00
1076	222	es	1	2019-01-26 05:02:37.354691+00
1077	222	es	2	2019-01-26 05:04:03.634191+00
1078	222	es	2	2019-01-26 05:04:26.125943+00
1079	222	es	3	2019-01-26 05:05:29.700856+00
1080	222	es	3	2019-01-26 05:05:55.795032+00
1081	222	es	4	2019-01-26 05:06:58.094507+00
1082	222	es	4	2019-01-26 05:07:24.085031+00
1083	222	es	5	2019-01-26 05:08:11.424462+00
1084	222	es	6	2019-01-26 05:15:07.887854+00
1085	222	es	6	2019-01-26 05:15:47.445474+00
1086	222	es	6	2019-01-26 05:16:18.500944+00
1087	222	es	7	2019-01-26 05:17:18.074491+00
1088	222	es	7	2019-01-26 05:17:52.775109+00
1089	222	es	7	2019-01-26 05:18:20.589806+00
1090	222	es	8	2019-01-26 05:19:25.962403+00
1091	222	es	8	2019-01-26 05:19:58.782326+00
1092	222	es	8	2019-01-26 05:20:28.195045+00
1093	222	es	9	2019-01-26 05:21:41.025222+00
1094	222	es	9	2019-01-26 05:22:04.543036+00
1095	222	es	10	2019-01-26 05:27:30.217471+00
1096	222	es	11	2019-01-26 05:28:25.159397+00
1097	222	es	12	2019-01-26 05:29:08.317208+00
1098	222	es	13	2019-01-26 05:30:57.616234+00
1099	222	es	14	2019-01-26 05:32:14.300085+00
1100	222	es	15	2019-01-26 05:36:14.099713+00
1101	222	es	15	2019-01-26 05:37:18.2834+00
1102	222	es	15	2019-01-26 05:38:44.435993+00
1103	222	es	16	2019-01-26 05:40:12.20634+00
1104	222	es	16	2019-01-26 05:40:53.444777+00
1105	222	es	17	2019-01-26 05:43:42.785943+00
1106	222	es	17	2019-01-26 05:44:27.778597+00
1107	222	es	17	2019-01-26 05:45:03.023018+00
1108	222	es	17	2019-01-26 05:45:33.248672+00
1109	222	es	18	2019-01-26 05:47:25.688664+00
1110	222	es	18	2019-01-26 05:48:04.1705+00
1111	222	es	18	2019-01-26 05:48:35.67452+00
1112	222	es	18	2019-01-26 05:49:00.478497+00
1113	222	es	18	2019-01-26 05:49:40.634429+00
1114	222	es	18	2019-01-26 05:50:08.211244+00
1115	222	es	18	2019-01-26 05:50:40.839068+00
1116	222	es	19	2019-01-26 05:52:07.355366+00
1117	222	es	20	2019-01-26 05:52:45.57862+00
1118	222	es	21	2019-01-26 05:53:38.893204+00
1119	222	es	22	2019-01-26 05:55:41.500288+00
1120	222	es	23	2019-01-26 05:56:29.747198+00
1121	222	es	24	2019-01-26 05:59:26.527898+00
1122	222	es	25	2019-01-26 06:01:12.721688+00
1123	222	es	26	2019-01-26 06:03:13.895172+00
\.


--
-- Name: backend_rule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backend_rule_id_seq', 1123, true);


--
-- Data for Name: backend_safetyprop; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backend_safetyprop (id, type, owner_id, always, task, lastedit) FROM stdin;
48	1	1	f	1	2018-08-09 17:33:58.730979+00
35	2	1	f	1	2018-08-09 17:33:58.730979+00
49	2	1	t	1	2018-08-09 17:33:58.730979+00
50	2	1	f	1	2018-08-09 17:33:58.730979+00
51	1	1	f	1	2018-08-09 17:33:58.730979+00
52	2	1	f	1	2018-08-09 17:33:58.730979+00
36	2	1	t	1	2018-08-09 17:33:58.730979+00
53	2	1	t	1	2018-08-09 17:33:58.730979+00
54	2	1	t	1	2018-08-09 17:33:58.730979+00
55	3	1	f	1	2018-08-09 17:33:58.730979+00
56	3	1	f	1	2018-08-09 17:33:58.730979+00
57	3	1	f	1	2018-08-09 17:33:58.730979+00
58	3	1	f	1	2018-08-09 17:33:58.730979+00
59	3	1	f	1	2018-08-09 17:33:58.730979+00
63	3	1	f	1	2018-08-09 17:33:58.730979+00
72	1	1	f	1	2018-08-10 16:17:32.325939+00
62	3	1	f	1	2018-08-09 19:01:20.148127+00
70	3	1	f	1	2018-08-09 20:56:44.829124+00
71	3	1	f	1	2018-08-09 20:58:28.520927+00
714	3	162	f	11	2018-08-21 00:00:08.326353+00
715	2	159	t	4	2018-08-21 00:02:37.408412+00
716	2	159	t	14	2018-08-21 00:06:49.968385+00
702	2	159	f	7	2018-08-20 23:39:36.853896+00
707	2	159	t	9	2018-08-20 23:50:49.224802+00
709	1	162	f	3	2018-08-20 23:52:56.349141+00
717	3	163	t	6	2018-08-21 00:08:31.143864+00
711	3	162	t	2	2018-08-20 23:57:45.317681+00
713	3	159	t	6	2018-08-21 00:00:03.515635+00
718	3	160	t	6	2018-08-21 00:10:14.069695+00
720	2	159	t	8	2018-08-21 00:12:52.688733+00
730	3	163	t	14	2018-08-21 00:26:26.496163+00
719	2	159	f	8	2018-08-21 00:13:10.129835+00
721	3	163	f	5	2018-08-21 00:14:15.926441+00
738	2	166	f	12	2018-08-21 00:33:16.088099+00
723	3	163	f	11	2018-08-21 00:16:58.730686+00
724	2	166	f	11	2018-08-21 00:18:00.432031+00
731	2	166	t	9	2018-08-21 00:26:55.16527+00
725	2	159	f	11	2018-08-21 00:20:05.289653+00
726	3	166	t	7	2018-08-21 00:20:26.868252+00
728	1	166	f	14	2018-08-21 00:23:11.064542+00
733	2	166	t	3	2018-08-21 00:29:48.086956+00
734	2	163	f	8	2018-08-21 00:31:15.469713+00
735	1	160	f	15	2018-08-21 00:31:27.002586+00
743	1	160	f	12	2018-08-21 00:40:04.976906+00
746	1	160	f	8	2018-08-21 00:44:36.295453+00
737	2	166	f	12	2018-08-21 00:32:49.228029+00
739	2	166	f	12	2018-08-21 00:34:00.069223+00
745	3	162	f	16	2018-08-21 00:43:25.438998+00
740	2	166	f	16	2018-08-21 00:36:44.981058+00
741	2	163	t	9	2018-08-21 00:38:23.364757+00
742	2	162	t	8	2018-08-21 00:39:43.307758+00
747	2	160	f	8	2018-08-21 00:46:35.040368+00
744	3	162	t	16	2018-08-21 00:43:46.268685+00
748	1	162	f	17	2018-08-21 00:47:13.782817+00
749	2	160	f	8	2018-08-21 00:47:52.88809+00
750	3	162	f	5	2018-08-21 00:50:16.365697+00
751	3	160	f	10	2018-08-21 00:52:32.454064+00
753	2	168	f	12	2018-08-21 00:55:36.168373+00
752	3	168	f	12	2018-08-21 00:55:58.405514+00
754	2	160	f	11	2018-08-21 00:57:11.254112+00
757	3	168	t	7	2018-08-21 01:04:12.840084+00
758	2	170	t	14	2018-08-21 01:09:17.331932+00
759	1	168	f	15	2018-08-21 01:13:35.963294+00
761	2	170	t	7	2018-08-21 01:16:28.439405+00
763	2	168	f	16	2018-08-21 01:20:46.326179+00
766	1	168	t	2	2018-08-21 01:25:52.12672+00
767	2	170	t	3	2018-08-21 01:26:50.438813+00
770	1	168	f	8	2018-08-21 01:36:00.104998+00
771	3	170	t	16	2018-08-21 01:37:32.199587+00
772	2	168	f	6	2018-08-21 01:39:29.670415+00
774	1	173	t	16	2018-08-21 01:47:59.560762+00
856	3	182	f	11	2018-08-21 02:48:37.122965+00
821	2	193	t	11	2018-08-21 02:30:49.08191+00
822	3	189	t	16	2018-08-21 02:31:21.44187+00
777	1	173	t	9	2018-08-21 01:52:50.708692+00
823	2	194	t	5	2018-08-21 02:31:50.499252+00
776	2	170	t	15	2018-08-21 01:53:33.016991+00
778	3	173	t	7	2018-08-21 01:56:19.731889+00
779	2	170	t	2	2018-08-21 01:57:34.210277+00
780	1	173	t	3	2018-08-21 01:59:32.7424+00
781	2	175	t	10	2018-08-21 02:01:52.761468+00
782	1	174	f	16	2018-08-21 02:02:20.480529+00
783	3	173	t	11	2018-08-21 02:02:22.020182+00
784	3	175	f	10	2018-08-21 02:02:24.514931+00
785	3	174	f	11	2018-08-21 02:04:40.143492+00
786	1	173	t	14	2018-08-21 02:05:02.596946+00
824	3	192	t	12	2018-08-21 02:31:52.545451+00
788	2	174	f	14	2018-08-21 02:07:25.678952+00
789	2	173	t	15	2018-08-21 02:07:55.313289+00
825	3	189	f	16	2018-08-21 02:32:43.351712+00
787	3	175	t	16	2018-08-21 02:08:36.930451+00
791	2	175	f	16	2018-08-21 02:09:28.649403+00
792	2	174	f	4	2018-08-21 02:09:32.106359+00
793	3	182	f	5	2018-08-21 02:10:10.412987+00
827	3	175	t	4	2018-08-21 02:34:09.70459+00
790	2	184	t	14	2018-08-21 02:10:19.555807+00
794	3	175	f	16	2018-08-21 02:10:31.835638+00
828	2	184	f	6	2018-08-21 02:34:29.785927+00
799	2	174	f	15	2018-08-21 02:16:33.077258+00
800	3	184	f	11	2018-08-21 02:16:33.762122+00
829	2	194	t	11	2018-08-21 02:34:45.775569+00
797	3	187	f	4	2018-08-21 02:16:52.140135+00
830	3	175	t	4	2018-08-21 02:34:56.863421+00
798	3	175	f	15	2018-08-21 02:17:00.885602+00
801	2	184	t	11	2018-08-21 02:17:32.185017+00
831	3	187	t	2	2018-08-21 02:35:28.160364+00
803	1	175	f	12	2018-08-21 02:20:44.658935+00
804	3	184	t	16	2018-08-21 02:21:13.481755+00
805	2	189	t	2	2018-08-21 02:22:21.352607+00
806	1	174	f	7	2018-08-21 02:22:28.97425+00
808	2	189	t	2	2018-08-21 02:23:39.604126+00
809	1	174	t	9	2018-08-21 02:24:21.267309+00
810	2	189	t	2	2018-08-21 02:25:16.911619+00
811	2	175	t	14	2018-08-21 02:25:40.917938+00
812	3	175	f	14	2018-08-21 02:26:05.063564+00
814	2	193	f	16	2018-08-21 02:28:27.226666+00
833	2	195	f	15	2018-08-21 02:36:12.150624+00
815	2	175	f	6	2018-08-21 02:28:40.579776+00
816	3	187	t	14	2018-08-21 02:28:50.2826+00
817	1	182	t	6	2018-08-21 02:28:54.980779+00
834	1	182	f	16	2018-08-21 02:36:33.526801+00
835	3	189	t	7	2018-08-21 02:36:52.312534+00
836	1	193	f	15	2018-08-21 02:38:50.449656+00
837	3	187	t	9	2018-08-21 02:39:05.86638+00
838	3	189	f	11	2018-08-21 02:39:32.25991+00
839	3	187	t	9	2018-08-21 02:40:32.641387+00
840	2	184	t	8	2018-08-21 02:40:44.939272+00
841	2	193	t	14	2018-08-21 02:41:23.606425+00
818	2	184	f	5	2019-01-24 05:01:35.618466+00
819	2	184	f	5	2019-01-24 05:01:51.167473+00
712	3	160	f	4	2019-01-24 05:05:19.475558+00
769	2	170	t	5	2019-01-24 05:05:49.728058+00
826	3	175	f	4	2019-01-24 05:07:34.874635+00
842	3	197	t	7	2018-08-21 02:41:55.235503+00
843	3	189	f	10	2018-08-21 02:42:14.12674+00
844	2	195	f	9	2018-08-21 02:42:20.844607+00
857	3	197	f	10	2018-08-21 02:49:07.512244+00
845	2	194	f	6	2018-08-21 02:42:27.715648+00
846	2	189	t	10	2018-08-21 02:42:46.011937+00
847	1	193	f	12	2018-08-21 02:43:26.787977+00
848	3	197	f	11	2018-08-21 02:44:29.190242+00
849	2	194	f	7	2018-08-21 02:44:55.830342+00
850	2	182	t	8	2018-08-21 02:45:12.236035+00
851	2	193	f	10	2018-08-21 02:45:52.374032+00
852	1	189	t	3	2018-08-21 02:47:06.908226+00
853	1	197	f	15	2018-08-21 02:47:50.882078+00
854	3	192	t	16	2018-08-21 02:48:16.542652+00
855	2	195	f	14	2018-08-21 02:48:34.257699+00
858	2	193	t	8	2018-08-21 02:49:15.634801+00
859	2	200	t	12	2018-08-21 02:51:20.096019+00
860	1	187	f	15	2018-08-21 02:51:38.578372+00
862	1	194	t	15	2018-08-21 02:52:18.430257+00
863	1	189	t	8	2018-08-21 02:53:19.756407+00
864	3	192	t	15	2018-08-21 02:53:26.087233+00
874	3	182	f	12	2018-08-21 02:56:37.605907+00
865	2	195	f	16	2018-08-21 02:53:34.794027+00
868	2	189	f	8	2018-08-21 02:54:21.889862+00
869	2	196	t	14	2018-08-21 02:54:43.260643+00
870	3	182	f	12	2018-08-21 02:55:18.39013+00
871	3	182	f	12	2018-08-21 02:56:05.376135+00
872	3	192	t	8	2018-08-21 02:56:15.080494+00
875	3	192	t	8	2018-08-21 02:56:47.084359+00
876	3	187	t	11	2018-08-21 02:56:56.765426+00
877	1	197	t	14	2018-08-21 02:57:39.200233+00
878	3	194	f	16	2018-08-21 02:57:39.39942+00
879	3	194	t	16	2018-08-21 02:58:16.680511+00
881	3	192	t	7	2018-08-21 02:58:58.865925+00
882	3	187	t	7	2018-08-21 02:59:48.471613+00
883	2	195	f	8	2018-08-21 03:00:52.424589+00
884	2	192	f	4	2018-08-21 03:01:02.984609+00
886	1	194	f	12	2018-08-21 03:02:28.648769+00
887	3	192	t	6	2018-08-21 03:02:51.706646+00
888	1	194	f	12	2018-08-21 03:02:57.724973+00
889	1	194	f	12	2018-08-21 03:03:17.71705+00
891	1	182	t	9	2018-08-21 03:09:04.664414+00
894	1	195	f	3	2018-08-21 03:18:25.682821+00
895	3	196	f	11	2018-08-21 03:24:39.115316+00
896	2	195	f	6	2018-08-21 03:25:32.418935+00
897	2	196	f	7	2018-08-21 03:32:38.72467+00
898	2	201	f	7	2018-08-21 03:37:08.579499+00
900	3	196	t	3	2018-08-21 03:38:17.097931+00
901	3	202	t	9	2018-08-21 03:38:59.61629+00
902	3	202	t	9	2018-08-21 03:39:35.227938+00
903	2	202	t	10	2018-08-21 03:41:26.654775+00
904	3	202	t	15	2018-08-21 03:43:58.607646+00
905	2	202	f	4	2018-08-21 03:45:23.84419+00
906	1	196	f	2	2018-08-21 03:45:51.311919+00
908	2	205	f	16	2018-08-21 03:46:34.816107+00
909	2	202	f	7	2018-08-21 03:47:04.495026+00
910	3	202	f	14	2018-08-21 03:48:38.362898+00
911	2	201	t	2	2018-08-21 03:50:05.290882+00
912	2	202	f	11	2018-08-21 03:50:54.62256+00
917	3	196	t	4	2018-08-21 03:55:11.728887+00
918	2	205	t	5	2018-08-21 03:57:14.171262+00
919	2	205	t	3	2018-08-21 03:59:19.931961+00
921	2	205	t	3	2018-08-21 03:59:49.015237+00
922	3	205	t	6	2018-08-21 04:02:19.624166+00
923	2	205	t	15	2018-08-21 04:05:44.089639+00
924	1	201	f	14	2018-08-21 04:06:40.205558+00
925	2	205	f	7	2018-08-21 04:07:35.463682+00
926	3	201	t	6	2018-08-21 04:10:26.105522+00
927	2	201	f	16	2018-08-21 04:15:13.484423+00
928	1	211	f	8	2018-08-21 04:49:22.117749+00
929	2	211	f	12	2018-08-21 04:51:55.046369+00
932	1	211	f	3	2018-08-21 05:02:32.395564+00
933	2	211	f	2	2018-08-21 05:07:48.660317+00
934	2	211	f	10	2018-08-21 05:17:15.608784+00
936	3	215	t	7	2018-08-21 06:46:40.936493+00
937	3	215	t	3	2018-08-21 06:52:22.157918+00
939	2	215	t	2	2018-08-21 07:13:23.171769+00
940	2	215	t	2	2018-08-21 07:13:55.829333+00
941	3	215	f	11	2018-08-21 07:15:57.866769+00
942	3	215	f	15	2018-08-21 07:20:45.062155+00
943	2	215	t	8	2018-08-21 07:25:53.331591+00
944	3	217	t	15	2018-08-21 08:30:24.717622+00
945	2	217	t	16	2018-08-21 08:36:25.540846+00
946	2	217	f	6	2018-08-21 08:38:24.367365+00
947	2	217	t	14	2018-08-21 08:39:34.608408+00
948	2	217	t	8	2018-08-21 08:43:23.522923+00
949	2	217	t	9	2018-08-21 08:45:16.901697+00
950	3	217	t	12	2018-08-21 08:46:49.558024+00
953	3	200	t	3	2019-01-23 18:58:32.881107+00
954	2	200	f	7	2019-01-23 19:36:12.385932+00
955	2	200	t	8	2019-01-23 19:39:54.120965+00
956	2	200	f	10	2019-01-23 19:40:59.758959+00
957	3	200	f	11	2019-01-23 19:41:55.918671+00
958	1	200	f	14	2019-01-23 19:43:05.581712+00
893	2	196	t	5	2019-01-24 04:52:09.726496+00
931	2	211	f	5	2019-01-24 05:02:25.478129+00
920	3	201	f	5	2019-01-24 04:53:12.923294+00
727	3	163	f	4	2019-01-24 04:54:20.511382+00
867	3	197	f	4	2019-01-24 05:04:15.667156+00
938	3	215	f	4	2019-01-24 04:56:14.523777+00
861	1	197	t	9	2019-01-24 05:04:48.26939+00
914	3	205	t	9	2019-01-24 04:58:00.542682+00
916	2	205	t	9	2019-01-24 04:58:25.410612+00
795	3	184	f	4	2019-01-24 05:01:05.592358+00
907	3	201	f	11	2019-01-25 03:44:12.200621+00
935	3	211	f	11	2019-01-25 03:44:47.159963+00
959	1	221	f	1	2019-01-26 05:01:28.292168+00
960	1	221	f	2	2019-01-26 05:03:15.857888+00
961	1	221	f	3	2019-01-26 05:04:54.671594+00
962	1	221	f	4	2019-01-26 05:06:17.615516+00
963	1	221	f	5	2019-01-26 05:07:43.241444+00
964	1	221	f	6	2019-01-26 05:14:00.235323+00
965	1	221	f	7	2019-01-26 05:16:46.826735+00
966	1	221	f	8	2019-01-26 05:18:54.816613+00
967	1	221	f	9	2019-01-26 05:21:01.590858+00
968	2	221	f	10	2019-01-26 05:27:03.770584+00
969	2	221	f	11	2019-01-26 05:27:49.015439+00
970	2	221	f	12	2019-01-26 05:28:45.948613+00
972	2	221	f	14	2019-01-26 05:31:24.423612+00
971	2	221	f	13	2019-01-26 05:30:01.151427+00
973	2	221	t	15	2019-01-26 05:34:57.931917+00
974	2	221	t	16	2019-01-26 05:39:28.042637+00
975	2	221	t	17	2019-01-26 05:42:22.28645+00
976	2	221	t	17	2019-01-26 05:42:47.360045+00
977	2	221	t	18	2019-01-26 05:46:14.641375+00
978	2	221	t	18	2019-01-26 05:46:38.250737+00
979	3	221	f	19	2019-01-26 05:51:39.929212+00
980	3	221	f	20	2019-01-26 05:52:24.349463+00
981	3	221	f	21	2019-01-26 05:53:07.746764+00
982	3	221	f	22	2019-01-26 05:55:08.8177+00
983	3	221	f	23	2019-01-26 05:56:04.055873+00
984	3	221	f	24	2019-01-26 05:58:53.642103+00
985	3	221	f	25	2019-01-26 06:00:20.736354+00
986	3	221	t	26	2019-01-26 06:01:59.933473+00
987	2	238	t	1	2019-01-26 21:35:37.954147+00
988	2	238	t	1	2019-01-26 21:36:02.610366+00
989	2	238	t	2	2019-01-26 21:37:14.846101+00
990	1	238	f	2	2019-01-26 21:37:56.259134+00
991	2	238	t	2	2019-01-26 21:39:34.792824+00
992	2	238	t	2	2019-01-26 21:40:05.506004+00
993	1	238	f	3	2019-01-26 21:41:04.925088+00
994	2	238	t	3	2019-01-26 21:41:53.521469+00
995	3	238	f	4	2019-01-26 21:43:11.018032+00
996	3	238	f	4	2019-01-26 21:43:46.227004+00
997	2	238	f	5	2019-01-26 21:44:59.468602+00
998	2	238	t	5	2019-01-26 21:45:22.317236+00
999	2	238	t	6	2019-01-26 21:46:13.149379+00
1000	2	238	t	6	2019-01-26 21:46:23.706252+00
1001	3	238	t	7	2019-01-26 21:47:35.622797+00
1002	3	238	f	7	2019-01-26 21:48:01.858121+00
\.


--
-- Name: backend_safetyprop_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backend_safetyprop_id_seq', 1002, true);


--
-- Data for Name: backend_setparam; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backend_setparam (parameter_ptr_id, numopts) FROM stdin;
3	6
8	7
17	8
29	3
30	8
70	5
71	3
\.


--
-- Data for Name: backend_setparamopt; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backend_setparamopt (id, value, param_id) FROM stdin;
1	Red	3
2	Orange	3
3	Yellow	3
4	Green	3
5	Blue	3
6	Violet	3
7	Pop	8
8	Jazz	8
9	R&B	8
10	Hip-Hop	8
11	Rap	8
12	Country	8
13	News	8
14	Sunny	17
15	Cloudy	17
16	Partly Cloudy	17
17	Raining	17
18	Thunderstorms	17
19	Snowing	17
20	Hailing	17
21	Clear	17
24	Small	29
25	Medium	29
26	Large	29
27	No Toppings	30
28	Pepperoni	30
29	Vegetables	30
30	Sausage	30
31	Mushrooms	30
32	Ham & Pineapple	30
33	Extra Cheese	30
34	Anchovies	30
35	Home	70
36	Kitchen	70
37	Bedroom	70
38	Bathroom	70
39	Living Room	70
40	Anyone	71
41	Alice	71
42	Bobbie	71
44	A Family Member	71
43	A Guest	71
45	Nobody	71
\.


--
-- Name: backend_setparamopt_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backend_setparamopt_id_seq', 45, true);


--
-- Data for Name: backend_sp1; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backend_sp1 (safetyprop_ptr_id) FROM stdin;
48
51
72
709
728
735
743
746
748
759
766
770
774
777
780
782
786
803
806
809
817
834
836
847
852
853
860
861
862
863
877
886
888
889
891
894
906
924
928
932
958
959
960
961
962
963
964
965
966
967
990
993
\.


--
-- Data for Name: backend_sp1_triggers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backend_sp1_triggers (id, sp1_id, trigger_id) FROM stdin;
43	48	163
44	48	164
45	51	168
46	51	169
47	72	256
48	72	257
405	709	2863
406	709	2864
407	709	2865
408	728	2923
409	728	2924
410	735	2942
411	735	2943
412	735	2944
413	743	2973
414	743	2974
415	743	2975
416	743	2976
417	746	2983
418	746	2984
419	748	2995
420	748	2996
421	748	2997
422	748	2998
423	759	3036
424	759	3037
428	766	3052
429	766	3053
430	766	3054
434	770	3061
435	770	3062
436	770	3063
437	770	3064
440	774	3080
441	774	3081
442	774	3082
445	777	3095
446	777	3096
447	780	3102
448	780	3103
449	782	3107
450	782	3108
451	782	3109
452	786	3122
453	786	3123
456	803	3227
457	803	3228
458	806	3240
459	806	3241
460	809	3256
461	809	3257
462	817	3290
463	817	3291
464	834	3349
465	834	3350
466	836	3357
467	836	3358
468	836	3359
469	847	3394
470	847	3395
471	852	3406
472	852	3407
473	853	3410
474	853	3411
475	853	3412
476	860	3436
477	860	3437
478	860	3438
481	862	3443
482	862	3444
483	863	3451
484	863	3452
485	863	3453
488	877	3487
489	877	3488
490	886	3522
491	886	3523
492	888	3526
493	888	3527
494	889	3528
495	889	3529
496	891	3541
497	891	3542
498	891	3543
499	894	3558
500	894	3559
501	906	3604
502	906	3605
503	906	3606
507	924	3700
508	924	3701
513	928	3757
514	928	3758
515	928	3759
516	928	3760
517	932	3775
518	932	3776
523	958	3937
524	958	3938
525	861	3952
526	861	3953
527	959	3959
528	959	3960
529	960	3965
530	960	3966
531	961	3972
532	961	3973
533	962	3978
534	962	3979
535	963	3984
536	963	3985
537	964	3988
538	964	3989
539	964	3990
540	965	4001
541	965	4002
542	965	4003
543	966	4012
544	966	4013
545	966	4014
546	967	4024
547	967	4025
548	967	4026
549	990	4140
550	990	4141
551	993	4146
552	993	4147
553	993	4148
\.


--
-- Name: backend_sp1_triggers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backend_sp1_triggers_id_seq', 553, true);


--
-- Data for Name: backend_sp2; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backend_sp2 (safetyprop_ptr_id, comp, "time", state_id) FROM stdin;
49	\N	\N	166
50	\N	\N	167
52	>	60	170
36	\N	\N	171
53	\N	\N	175
54	\N	\N	179
35	>	300	115
740	>	1800	2961
742	\N	\N	2969
749	\N	\N	2999
739	\N	\N	2955
741	\N	\N	2965
747	\N	\N	2990
753	\N	\N	3013
754	\N	\N	3017
758	\N	\N	3031
850	\N	\N	3398
761	>	15	3039
821	\N	\N	3297
823	\N	\N	3304
763	>	1800	3044
702	>	15	2836
707	\N	\N	2851
767	\N	\N	3055
715	\N	\N	2886
716	\N	\N	2887
720	\N	\N	2899
719	\N	\N	2902
724	\N	\N	2913
851	\N	\N	3403
772	>	120	3069
725	\N	\N	2917
731	\N	\N	2929
828	>	120	3322
733	\N	\N	2934
734	\N	\N	2938
737	\N	\N	2949
738	\N	\N	2951
829	\N	\N	3325
833	\N	\N	3341
776	>	25200	3097
779	\N	\N	3101
781	\N	\N	3106
788	\N	\N	3138
789	>	10800	3141
840	\N	\N	3370
791	>	3600	3151
792	\N	\N	3153
841	\N	\N	3378
790	\N	\N	3164
799	\N	\N	3205
801	\N	\N	3215
805	\N	\N	3235
808	\N	\N	3249
810	\N	\N	3261
811	\N	\N	3267
844	\N	\N	3387
814	>	3600	3285
815	>	180	3287
855	\N	\N	3415
845	>	120	3392
846	\N	\N	3393
849	>	15	3397
858	\N	\N	3421
859	\N	\N	3434
865	>	1800	3458
868	\N	\N	3466
869	\N	\N	3468
883	\N	\N	3513
884	\N	\N	3517
896	>	120	3565
897	>	15	3572
898	>	15	3579
903	\N	\N	3588
905	\N	\N	3603
908	>	1800	3614
909	>	15	3617
911	\N	\N	3626
912	\N	\N	3627
918	\N	\N	3655
919	\N	\N	3664
921	\N	\N	3669
923	>	10800	3691
925	>	15	3702
927	>	1800	3726
929	\N	\N	3761
933	\N	\N	3779
934	\N	\N	3789
939	\N	\N	3842
940	\N	\N	3843
943	\N	\N	3851
945	>	2100	3881
946	>	120	3892
947	\N	\N	3893
948	\N	\N	3898
949	\N	\N	3904
954	>	15	3930
955	\N	\N	3931
956	\N	\N	3935
893	\N	\N	3939
916	\N	\N	3945
818	\N	\N	3948
819	\N	\N	3949
931	\N	\N	3950
769	\N	\N	3955
968	\N	\N	4033
969	\N	\N	4035
970	\N	\N	4038
971	>	60	4040
972	>	60	4042
973	\N	\N	4045
974	\N	\N	4061
975	\N	\N	4073
976	\N	\N	4075
977	\N	\N	4085
978	\N	\N	4087
987	\N	\N	4132
988	\N	\N	4134
989	\N	\N	4136
991	\N	\N	4142
992	\N	\N	4144
994	\N	\N	4149
997	>	86400	4157
998	\N	\N	4158
999	\N	\N	4160
1000	\N	\N	4162
\.


--
-- Data for Name: backend_sp2_conds; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backend_sp2_conds (id, sp2_id, trigger_id) FROM stdin;
14	36	172
15	36	173
16	36	174
17	53	176
19	54	180
176	707	2852
177	716	2888
183	720	2900
184	720	2901
185	719	2903
186	719	2904
187	719	2905
188	719	2906
189	719	2907
190	731	2930
191	733	2935
192	734	2939
193	734	2940
194	734	2941
195	737	2950
196	738	2952
198	739	2956
199	740	2962
200	741	2966
201	742	2970
202	742	2971
203	742	2972
204	747	2991
205	749	3000
206	753	3014
207	758	3032
208	763	3045
209	767	3056
211	776	3098
212	788	3139
213	788	3140
214	789	3142
216	791	3152
217	792	3154
218	790	3165
219	799	3206
220	805	3236
221	805	3237
222	808	3250
223	808	3251
224	810	3262
225	810	3263
226	811	3268
227	814	3286
229	833	3342
230	833	3343
231	840	3371
232	840	3372
233	840	3373
234	841	3379
235	844	3388
236	850	3399
237	850	3400
238	855	3416
239	855	3417
240	858	3422
241	858	3423
242	858	3424
243	859	3435
244	865	3459
245	868	3467
246	869	3469
247	869	3470
248	883	3514
249	883	3515
250	883	3516
254	908	3615
258	919	3665
259	921	3670
260	923	3692
261	927	3727
262	929	3762
263	933	3780
264	943	3852
265	943	3853
266	943	3854
267	945	3882
268	947	3894
269	948	3899
270	948	3900
271	948	3901
272	949	3905
273	955	3932
274	955	3933
275	955	3934
276	916	3946
277	973	4046
278	973	4047
279	973	4048
280	974	4062
281	974	4063
282	974	4064
283	975	4074
284	976	4076
285	977	4086
286	978	4088
287	987	4133
288	988	4135
289	989	4137
290	989	4138
291	989	4139
292	991	4143
293	992	4145
294	994	4150
295	994	4151
296	994	4152
297	998	4159
298	999	4161
\.


--
-- Name: backend_sp2_conds_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backend_sp2_conds_id_seq', 298, true);


--
-- Data for Name: backend_sp3; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backend_sp3 (safetyprop_ptr_id, comp, occurrences, "time", event_id, timecomp) FROM stdin;
70	>	2	60	210	\N
71	>	2	60	211	\N
55	\N	\N	\N	181	\N
56	\N	\N	\N	182	\N
57	\N	\N	\N	183	\N
58	\N	\N	\N	187	\N
59	\N	\N	\N	189	\N
63	\N	\N	7200	198	<
62	\N	\N	\N	204	\N
816	\N	\N	\N	3288	\N
822	\N	\N	\N	3299	\N
824	\N	\N	\N	3305	\N
711	\N	\N	\N	2877	\N
713	\N	\N	\N	2881	\N
714	\N	\N	\N	2883	\N
717	\N	\N	120	2889	<
718	\N	\N	120	2891	<
721	\N	\N	\N	2908	\N
825	\N	\N	1800	3307	<
723	\N	\N	\N	2911	\N
726	\N	\N	15	2919	<
730	\N	\N	\N	2927	\N
827	\N	\N	\N	3318	\N
745	\N	\N	1800	2979	<
830	\N	\N	\N	3326	\N
744	\N	\N	1860	2981	>
750	\N	\N	\N	3006	\N
751	\N	\N	\N	3010	\N
831	\N	\N	\N	3332	\N
752	\N	\N	\N	3015	\N
757	\N	\N	15	3024	<
771	\N	\N	\N	3065	\N
778	\N	\N	930	3099	<
783	\N	\N	\N	3110	\N
784	\N	\N	\N	3112	\N
785	\N	\N	\N	3118	\N
835	\N	\N	900	3352	<
787	\N	\N	3600	3147	>
793	\N	\N	\N	3161	\N
794	\N	\N	1800	3167	<
837	\N	\N	\N	3360	\N
800	\N	\N	\N	3207	\N
797	\N	\N	\N	3208	\N
838	\N	\N	\N	3362	\N
798	\N	\N	10800	3212	>
804	\N	\N	1800	3231	<
812	\N	\N	\N	3269	\N
839	\N	\N	\N	3368	\N
842	\N	\N	15	3384	<
843	\N	\N	\N	3386	\N
848	\N	\N	\N	3396	\N
854	\N	\N	2400	3413	<
856	\N	\N	\N	3418	\N
857	\N	\N	\N	3420	\N
864	\N	\N	\N	3454	\N
870	\N	\N	\N	3471	\N
871	\N	\N	\N	3476	\N
872	\N	\N	\N	3478	\N
874	\N	\N	\N	3481	\N
875	\N	\N	\N	3483	\N
876	\N	\N	\N	3485	\N
878	\N	\N	1800	3489	<
879	\N	\N	1860	3495	<
881	\N	\N	15	3501	<
882	\N	\N	15	3506	<
887	\N	\N	120	3524	<
895	\N	\N	\N	3564	\N
900	\N	\N	\N	3580	\N
901	\N	\N	\N	3582	\N
902	\N	\N	\N	3584	\N
904	\N	\N	\N	3600	\N
910	\N	\N	\N	3622	\N
917	\N	\N	\N	3648	\N
922	\N	\N	120	3678	<
926	\N	\N	120	3709	<
936	\N	\N	15	3823	<
937	\N	\N	\N	3825	\N
941	\N	\N	\N	3844	\N
942	\N	\N	\N	3848	\N
944	\N	\N	10800	3878	<
950	\N	\N	\N	3906	\N
953	\N	\N	\N	3928	\N
957	\N	\N	\N	3936	\N
920	\N	\N	\N	3940	\N
727	\N	\N	\N	3941	\N
938	\N	\N	\N	3942	\N
914	\N	\N	\N	3943	\N
795	\N	\N	\N	3947	\N
867	\N	\N	\N	3951	\N
712	\N	\N	\N	3954	\N
826	\N	\N	\N	3956	\N
907	\N	\N	\N	3957	\N
935	\N	\N	\N	3958	\N
979	\N	\N	\N	4103	\N
980	\N	\N	\N	4106	\N
981	\N	\N	\N	4108	\N
982	\N	\N	\N	4110	\N
983	\N	\N	\N	4114	\N
984	\N	\N	\N	4118	\N
985	\N	\N	10800	4123	<
986	\N	\N	1800	4127	<
995	\N	\N	10800	4153	<
996	\N	\N	\N	4155	\N
1001	\N	\N	1860	4163	<
1002	\N	\N	1800	4165	<
\.


--
-- Data for Name: backend_sp3_conds; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backend_sp3_conds (id, sp3_id, trigger_id) FROM stdin;
10	57	184
12	58	188
13	59	190
17	63	199
18	62	205
234	711	2878
235	713	2882
236	717	2890
237	718	2892
239	726	2920
241	730	2928
245	745	2980
246	744	2982
248	752	3016
250	757	3025
251	771	3066
253	778	3100
254	783	3111
256	787	3148
257	794	3168
260	797	3209
261	798	3213
262	804	3232
264	812	3270
265	816	3289
266	822	3300
267	824	3306
268	825	3308
269	827	3319
270	830	3327
271	831	3333
272	835	3353
273	837	3361
274	839	3369
275	842	3385
276	854	3414
277	864	3455
278	870	3472
279	871	3477
280	872	3479
281	874	3482
282	875	3484
283	876	3486
284	878	3490
285	879	3496
286	881	3502
287	882	3507
288	887	3525
290	900	3581
291	901	3583
292	902	3585
293	904	3601
294	910	3623
296	917	3649
297	922	3679
298	926	3710
300	936	3824
301	937	3826
302	942	3849
303	944	3879
304	950	3907
305	953	3929
306	914	3944
307	982	4111
308	983	4115
309	984	4119
310	985	4124
311	986	4128
312	995	4154
313	996	4156
314	1001	4164
315	1002	4166
\.


--
-- Name: backend_sp3_conds_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backend_sp3_conds_id_seq', 315, true);


--
-- Data for Name: backend_ssrule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backend_ssrule (priority, action_id, rule_ptr_id) FROM stdin;
\.


--
-- Data for Name: backend_ssrule_triggers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backend_ssrule_triggers (id, ssrule_id, trigger_id) FROM stdin;
\.


--
-- Name: backend_ssrule_triggers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backend_ssrule_triggers_id_seq', 1, false);


--
-- Data for Name: backend_state; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backend_state (id, cap_id, dev_id, action, text, chan_id) FROM stdin;
18	35	7	t	Start playing despacito on Speakers	\N
19	35	7	t	Start playing despacito on Speakers	\N
22	8	3	t	Set Amazon Echo's Volume to 47	3
23	64	22	t	Turn On Smart Faucet's water	17
26	64	22	t	Turn On Smart Faucet's water	17
27	64	22	t	Turn On Smart Faucet's water	17
28	64	22	t	Turn On Smart Faucet's water	17
29	64	22	t	Turn On Smart Faucet's water	17
33	31	3	t	(Amazon Echo) Order 500 {size} Pizza(s) with Vegetables	11
41	2	5	t	Turn Smart TV On	12
42	2	5	t	Turn Smart TV On	12
44	14	25	t	Close Living Room Window	5
46	14	24	t	Open Bathroom Window	5
47	14	14	t	Open Bedroom Window	5
48	14	25	t	Open Living Room Window	5
49	60	23	t	Close Smart Oven's Door	13
50	60	23	t	Close Smart Oven's Door	13
51	21	2	t	Set Thermostat to 75	8
52	66	8	t	Set Smart Refrigerator's temperature to 45	13
53	64	22	t	Turn Off Smart Faucet's water	13
54	64	22	t	Turn Off Smart Faucet's water	17
55	14	14	t	Open Bedroom Window	5
56	14	14	t	Open Bedroom Window	5
57	14	14	t	Open Bedroom Window	5
58	14	14	t	Open Bedroom Window	5
68	66	8	t	Set Smart Refrigerator's temperature to 40	13
84	64	22	t	Turn Off Smart Faucet's water	17
98	60	8	t	Close Smart Refrigerator's Door	13
99	21	2	t	Set Thermostat to 70	8
115	13	13	t	Lock Front Door Lock	4
117	13	13	t	Lock Front Door Lock	4
143	2	5	t	Turn Smart TV Off	12
156	57	2	t	Turn On the AC	8
170	2	5	t	Turn Smart TV On	12
203	14	14	t	Open Bedroom Window	5
205	14	14	t	Open Bedroom Window	5
231	14	14	t	Open Bedroom Window	5
243	14	14	t	Close Bedroom Window	5
248	56	3	t	Stop playing music on Amazon Echo	3
257	13	13	t	Lock Front Door Lock	4
267	14	14	t	Open Bedroom Window	5
313	65	23	t	Set Smart Oven's temperature to 5	13
316	13	13	t	Lock Front Door Lock	5
333	14	14	t	Open Bedroom Window	5
335	13	23	t	Lock Smart Oven	13
344	14	24	t	Open Bathroom Window	5
346	14	25	t	Open Living Room Window	5
353	64	22	t	Turn Off Smart Faucet's water	17
367	13	13	t	Unlock Front Door Lock	5
398	2	5	t	Turn Smart TV Off	12
399	2	5	t	Turn Smart TV Off	12
400	2	5	t	Turn Smart TV Off	12
401	31	3	t	(Amazon Echo) Order 1 Medium Pizza(s) with Pepperoni	13
402	27	17	t	Set off Clock's alarm	9
403	14	25	t	Close Living Room Window	5
404	14	25	t	Close Living Room Window	5
407	21	2	t	Set Thermostat to 72	8
410	2	1	t	Turn Roomba Off	18
411	2	1	t	Turn Roomba Off	18
412	60	8	t	Close Smart Refrigerator's Door	13
425	60	8	t	Close Smart Refrigerator's Door	13
436	14	14	t	Open Bedroom Window	5
448	60	23	t	Close Smart Oven's Door	13
454	2	1	t	Turn Roomba On	18
475	2	1	t	Turn Roomba Off	18
476	64	22	t	Turn Off Smart Faucet's water	17
478	64	22	t	Turn Off Smart Faucet's water	17
482	64	22	t	Turn Off Smart Faucet's water	17
491	66	8	t	Set Smart Refrigerator's temperature to 40	13
614	14	24	t	Open Bathroom Window	5
497	21	2	t	Set Thermostat to 73	8
499	21	2	t	Set Thermostat to 73	8
500	21	2	t	Set Thermostat to 73	8
506	9	3	t	Start playing Country on Amazon Echo	3
509	57	2	t	Turn Off the AC	8
520	14	24	t	Close Bathroom Window	5
530	2	1	t	Turn Roomba On	18
533	2	1	t	Turn Roomba Off	18
544	64	22	t	Turn Off Smart Faucet's water	17
857	2	1	t	Turn Roomba On	18
551	21	2	t	Set Thermostat to 69	8
552	21	2	t	Set Thermostat to 69	8
553	21	2	t	Set Thermostat to 69	8
554	21	2	t	Set Thermostat to 69	8
557	2	9	t	Turn Coffee Pot Off	1
586	14	14	t	Open Bedroom Window	5
595	2	1	t	Turn Roomba Off	18
600	13	23	t	Lock Smart Oven	13
616	14	14	t	Open Bedroom Window	5
617	14	25	t	Open Living Room Window	5
624	21	2	t	Set Thermostat to 73	8
628	56	3	t	Stop playing music on Amazon Echo	3
631	66	8	t	Set Smart Refrigerator's temperature to 45	13
632	58	24	t	Close Bathroom Window's Curtains	5
653	66	8	t	Set Smart Refrigerator's temperature to 41	13
657	58	24	t	Close Bathroom Window's Curtains	5
700	2	1	t	Turn Roomba Off	18
745	58	24	t	Close Bathroom Window's Curtains	5
746	58	14	t	Close Bedroom Window's Curtains	5
760	56	3	t	Stop playing music on Amazon Echo	3
779	58	24	t	Close Bathroom Window's Curtains	5
794	14	14	t	Close Bedroom Window	5
830	6	4	t	Set HUE Lights's Color to Red	2
856	13	23	t	Lock Smart Oven	13
858	66	8	t	Set Smart Refrigerator's temperature to 40	13
859	2	5	t	Turn Smart TV Off	1
860	14	25	t	Open Living Room Window	5
861	14	24	t	Open Bathroom Window	5
862	14	14	t	Open Bedroom Window	5
863	2	5	t	Turn Smart TV Off	12
864	13	23	t	Lock Smart Oven	13
865	57	2	t	Turn On the AC	8
866	57	2	t	Turn On the AC	8
867	64	22	t	Turn Off Smart Faucet's water	13
868	14	25	t	Open Living Room Window	5
869	14	25	t	Open Living Room Window	5
870	14	24	t	Open Bathroom Window	5
871	57	2	t	Turn On the AC	8
873	14	24	t	Open Bathroom Window	5
874	14	25	t	Open Living Room Window	5
875	58	14	t	Close Bedroom Window's Curtains	5
876	2	1	t	Turn Roomba Off	18
877	9	3	t	Start playing R&B on Amazon Echo	3
878	13	13	t	Lock Front Door Lock	5
879	14	14	t	Open Bedroom Window	5
880	14	14	t	Close Bedroom Window	5
881	14	14	t	Open Bedroom Window	5
882	56	3	t	Stop playing music on Amazon Echo	3
883	14	14	t	Close Bedroom Window	5
884	64	22	t	Turn On Smart Faucet's water	17
885	9	3	t	Start playing R&B on Amazon Echo	3
886	64	22	t	Turn Off Smart Faucet's water	17
887	66	8	t	Set Smart Refrigerator's temperature to 40	13
888	2	1	t	Turn Roomba Off	18
889	66	8	t	Set Smart Refrigerator's temperature to 40	13
890	13	23	t	Lock Smart Oven	13
891	13	23	t	Lock Smart Oven	13
892	2	5	t	Turn Smart TV On	12
893	2	1	t	Turn Roomba Off	18
894	2	5	t	Turn Smart TV Off	12
895	2	1	t	Turn Roomba Off	18
896	2	1	t	Turn Roomba Off	18
897	58	24	t	Close Bathroom Window's Curtains	5
898	66	8	t	Set Smart Refrigerator's temperature to 40	13
899	2	1	t	Turn Roomba Off	18
900	14	14	t	Open Bedroom Window	5
901	60	8	t	Close Smart Refrigerator's Door	13
902	64	22	t	Turn Off Smart Faucet's water	17
903	64	22	t	Turn Off Smart Faucet's water	17
904	13	23	t	Lock Smart Oven	13
905	2	1	t	Turn Roomba Off	18
906	60	8	t	Close Smart Refrigerator's Door	13
907	58	24	t	Close Bathroom Window's Curtains	5
908	56	3	t	Stop playing music on Amazon Echo	3
909	2	5	t	Turn Smart TV Off	12
910	13	13	t	Lock Front Door Lock	4
912	27	17	t	Set off Clock's alarm	9
913	27	17	t	Set off Clock's alarm	9
915	56	3	t	Stop playing music on Amazon Echo	3
917	2	1	t	Turn Roomba On	18
918	13	14	t	Unlock Bedroom Window	4
919	58	24	t	Close Bathroom Window's Curtains	5
921	14	14	t	Open Bedroom Window	5
922	56	3	t	Stop playing music on Amazon Echo	3
923	57	2	t	Turn On the AC	8
924	14	24	t	Open Bathroom Window	5
925	2	1	t	Turn Roomba Off	18
929	13	14	t	Unlock Bedroom Window	5
930	13	14	t	Unlock Bedroom Window	5
931	14	25	t	Open Living Room Window	5
932	14	14	t	Open Bedroom Window	5
933	57	2	t	Turn On the AC	8
934	14	24	t	Open Bathroom Window	5
935	14	24	t	Open Bathroom Window	5
936	14	14	t	Open Bedroom Window	5
938	57	2	t	Turn On the AC	8
939	57	2	t	Turn On the AC	8
940	57	2	t	Turn On the AC	8
941	58	25	t	Close Living Room Window's Curtains	5
944	40	10	t	Turn Security Camera's Siren On	4
945	40	10	t	Turn Security Camera's Siren On	4
947	2	5	t	Turn Smart TV Off	12
948	60	8	t	Close Smart Refrigerator's Door	13
949	56	3	t	Stop playing music on Amazon Echo	3
950	58	24	t	Close Bathroom Window's Curtains	5
951	21	2	t	Set Thermostat to 73	8
952	64	22	t	Turn Off Smart Faucet's water	17
953	64	22	t	Turn Off Smart Faucet's water	17
955	13	23	t	Lock Smart Oven	13
956	56	3	t	Stop playing music on Amazon Echo	3
957	21	2	t	Set Thermostat to 75	8
958	21	2	t	Set Thermostat to 80	8
961	58	25	t	Close Living Room Window's Curtains	5
962	13	23	t	Lock Smart Oven	13
963	58	24	t	Close Bathroom Window's Curtains	5
964	66	8	t	Set Smart Refrigerator's temperature to 40	13
965	58	24	t	Close Bathroom Window's Curtains	5
966	13	23	t	Lock Smart Oven	13
967	2	1	t	Turn Roomba On	18
968	57	2	t	Turn On the AC	8
969	60	23	t	Close Smart Oven's Door	13
971	13	13	t	Lock Front Door Lock	5
974	13	13	t	Lock Front Door Lock	5
975	14	24	t	Open Bathroom Window	5
976	35	3	t	Start playing something else on Amazon Echo	3
977	21	2	t	Set Thermostat to 75	8
980	64	22	t	Turn Off Smart Faucet's water	17
981	13	23	t	Lock Smart Oven	13
982	58	25	t	Close Living Room Window's Curtains	5
983	14	14	t	Close Bedroom Window	5
987	14	14	t	Close Bedroom Window	5
988	14	25	t	Open Living Room Window	5
989	14	14	t	Open Bedroom Window	5
990	14	14	t	Close Bedroom Window	5
991	14	14	t	Open Bedroom Window	5
993	14	14	t	Close Bedroom Window	5
994	13	13	t	Unlock Front Door Lock	5
995	14	24	t	Open Bathroom Window	5
997	14	14	t	Close Bedroom Window	5
998	14	14	t	Close Bedroom Window	5
999	21	2	t	Set Thermostat to 72	8
1001	14	14	t	Close Bedroom Window	5
1003	14	14	t	Close Bedroom Window	5
1004	58	24	t	Close Bathroom Window's Curtains	5
1005	14	14	t	Close Bedroom Window	5
1007	2	1	t	Turn Roomba Off	18
1008	2	5	t	Turn Smart TV Off	12
1009	60	8	t	Close Smart Refrigerator's Door	13
1010	60	8	t	Close Smart Refrigerator's Door	13
1011	60	8	t	Close Smart Refrigerator's Door	13
1012	66	8	t	Set Smart Refrigerator's temperature to 35	13
1013	58	25	t	Close Living Room Window's Curtains	5
1014	2	1	t	Turn Roomba Off	18
1016	58	14	t	Close Bedroom Window's Curtains	5
1017	58	24	t	Close Bathroom Window's Curtains	5
1018	58	25	t	Open Living Room Window's Curtains	5
1019	57	2	t	Turn On the AC	8
1020	58	14	t	Open Bedroom Window's Curtains	5
1021	21	2	t	Set Thermostat to 80	8
1022	58	24	t	Open Bathroom Window's Curtains	5
1023	57	2	t	Turn On the AC	8
1024	57	2	t	Turn On the AC	8
1025	14	14	t	Open Bedroom Window	5
1027	14	24	t	Open Bathroom Window	5
1028	14	25	t	Open Living Room Window	5
1029	2	5	t	Turn Smart TV Off	12
1030	14	24	t	Open Bathroom Window	5
1031	2	5	t	Turn Smart TV Off	12
1032	2	1	t	Turn Roomba Off	18
1034	13	13	t	Lock Front Door Lock	4
1035	2	1	t	Turn Roomba Off	18
1037	2	1	t	Turn Roomba On	18
1038	2	1	t	Turn Roomba Off	18
1039	2	1	t	Turn Roomba Off	18
1040	2	1	t	Turn Roomba Off	18
1041	58	25	t	Open Living Room Window's Curtains	5
1043	57	2	t	Turn On the AC	8
1044	57	2	t	Turn On the AC	8
1045	57	2	t	Turn On the AC	8
1046	57	2	t	Turn On the AC	8
1047	57	2	t	Turn On the AC	8
1049	64	22	t	Turn Off Smart Faucet's water	17
1051	57	2	t	Turn Off the AC	8
1052	57	2	t	Turn Off the AC	8
1053	14	14	t	Open Bedroom Window	5
1054	14	24	t	Open Bathroom Window	5
1055	14	25	t	Open Living Room Window	5
1056	35	3	t	Start playing Jazz on Amazon Echo	3
1057	14	14	t	Open Bedroom Window	5
1058	14	24	t	Open Bathroom Window	5
1062	2	5	t	Turn Smart TV Off	12
1063	66	8	t	Set Smart Refrigerator's temperature to 43	13
1064	66	8	t	Set Smart Refrigerator's temperature to 43	13
1065	64	22	t	Turn Off Smart Faucet's water	17
1066	66	8	t	Set Smart Refrigerator's temperature to 43	13
1067	64	22	t	Turn Off Smart Faucet's water	17
1068	64	22	t	Turn Off Smart Faucet's water	17
1069	9	3	t	Start playing R&B on Amazon Echo	3
1070	2	1	t	Turn Roomba On	18
1071	2	1	t	Turn Roomba On	18
1072	21	2	t	Set Thermostat to 73	8
1073	66	8	t	Set Smart Refrigerator's temperature to 40	13
1074	21	2	t	Set Thermostat to 73	8
1075	2	5	t	Turn Smart TV Off	12
1076	14	14	t	Close Bedroom Window	5
1077	56	3	t	Stop playing music on Amazon Echo	3
1078	14	14	t	Close Bedroom Window	5
1079	14	14	t	Close Bedroom Window	5
1080	14	14	t	Close Bedroom Window	5
1081	57	2	t	Turn On the AC	8
1082	58	14	t	Open Bedroom Window's Curtains	5
1083	57	2	t	Turn On the AC	8
1084	57	2	t	Turn On the AC	8
1085	58	24	t	Close Bathroom Window's Curtains	5
1087	2	23	t	Turn Smart Oven Off	13
1088	58	14	t	Close Bedroom Window's Curtains	5
1089	58	25	t	Close Living Room Window's Curtains	5
1090	56	3	t	Stop playing music on Amazon Echo	3
1091	9	3	t	Start playing Hip-Hop on Amazon Echo	3
1092	2	5	t	Turn Smart TV Off	1
1093	14	25	t	Open Living Room Window	5
1094	14	14	t	Close Bedroom Window	5
1095	2	1	t	Turn Roomba On	18
1096	21	2	t	Set Thermostat to 70	8
1097	14	14	t	Open Bedroom Window	5
1098	2	1	t	Turn Roomba Off	1
1099	2	1	t	Turn Roomba Off	1
1100	2	1	t	Turn Roomba Off	1
1101	2	1	t	Turn Roomba Off	18
1102	14	14	t	Close Bedroom Window	5
1103	14	14	t	Close Bedroom Window	5
1104	13	23	t	Lock Smart Oven	13
1106	2	1	t	Turn Roomba Off	1
1107	14	25	t	Open Living Room Window	5
1108	14	24	t	Open Bathroom Window	5
1109	66	8	t	Set Smart Refrigerator's temperature to 45	13
1110	14	14	t	Open Bedroom Window	5
1111	13	23	t	Lock Smart Oven	13
1112	13	13	t	Lock Front Door Lock	5
1113	64	22	t	Turn Off Smart Faucet's water	17
1115	27	17	t	Set off Clock's alarm	9
1116	60	8	t	Close Smart Refrigerator's Door	13
1117	64	22	t	Turn Off Smart Faucet's water	17
1118	2	1	t	Turn Roomba Off	18
1119	60	8	t	Close Smart Refrigerator's Door	13
1120	2	5	t	Turn Smart TV Off	1
1121	60	8	t	Close Smart Refrigerator's Door	13
1122	58	24	t	Close Bathroom Window's Curtains	5
1123	58	14	t	Close Bedroom Window's Curtains	5
1124	58	25	t	Close Living Room Window's Curtains	5
1125	13	13	t	Lock Front Door Lock	4
1126	40	10	t	Turn Security Camera's Siren On	4
1127	2	5	t	Turn Smart TV Off	1
1128	14	25	t	Open Living Room Window	5
1129	2	1	t	Turn Roomba On	18
1130	2	1	t	Turn Roomba On	18
1131	2	1	t	Turn Roomba On	18
1132	64	22	t	Turn Off Smart Faucet's water	17
1133	64	22	t	Turn On Smart Faucet's water	13
1135	64	22	t	Turn Off Smart Faucet's water	17
1136	64	22	t	Turn Off Smart Faucet's water	17
1137	64	22	t	Turn Off Smart Faucet's water	17
1138	56	3	t	Stop playing music on Amazon Echo	3
1140	21	2	t	Set Thermostat to 80	8
1141	57	2	t	Turn On the AC	8
1143	2	5	t	Turn Smart TV Off	12
1144	2	5	t	Turn Smart TV Off	12
1145	2	5	t	Turn Smart TV Off	12
1147	2	5	t	Turn Smart TV Off	12
1148	58	25	t	Open Living Room Window's Curtains	5
1149	14	14	t	Open Bedroom Window	5
1150	14	25	t	Open Living Room Window	5
1151	58	25	t	Close Living Room Window's Curtains	5
1152	57	2	t	Turn Off the AC	8
1153	21	2	t	Set Thermostat to 70	8
1154	57	2	t	Turn On the AC	8
1155	58	24	t	Close Bathroom Window's Curtains	5
1156	9	3	t	Start playing R&B on Amazon Echo	3
1157	58	14	t	Close Bedroom Window's Curtains	5
1158	9	3	t	Start playing R&B on Amazon Echo	3
1159	2	1	t	Turn Roomba Off	1
1160	27	17	t	Set off Clock's alarm	9
1161	13	23	t	Lock Smart Oven	13
1162	14	14	t	Close Bedroom Window	5
1163	2	5	t	Turn Smart TV Off	12
1164	13	13	t	Lock Front Door Lock	5
1165	14	25	t	Open Living Room Window	5
1166	14	14	t	Open Bedroom Window	5
1167	14	14	t	Open Bedroom Window	5
1168	58	25	t	Close Living Room Window's Curtains	5
1169	58	24	t	Close Bathroom Window's Curtains	5
1170	58	14	t	Close Bedroom Window's Curtains	5
1171	64	22	t	Turn Off Smart Faucet's water	17
1173	56	3	t	Stop playing music on Amazon Echo	3
1174	13	23	t	Lock Smart Oven	13
1177	57	2	t	Turn On the AC	8
1178	21	2	t	Set Thermostat to 72	8
1179	57	2	t	Turn Off the AC	8
1180	57	2	t	Turn Off the AC	8
1181	57	2	t	Turn Off the AC	8
1182	21	2	t	Set Thermostat to 62	8
1183	21	2	t	Set Thermostat to 62	8
1184	2	5	t	Turn Smart TV Off	1
1185	2	1	t	Turn Roomba Off	18
1186	2	1	t	Turn Roomba On	1
1187	13	23	t	Lock Smart Oven	13
1188	58	24	t	Close Bathroom Window's Curtains	5
1189	57	2	t	Turn On the AC	8
1190	14	25	t	Open Living Room Window	5
1191	14	24	t	Open Bathroom Window	5
1192	14	14	t	Open Bedroom Window	5
1193	13	13	t	Lock Front Door Lock	5
1194	13	13	t	Lock Front Door Lock	5
1195	13	13	t	Lock Front Door Lock	4
1196	66	8	t	Set Smart Refrigerator's temperature to 42	13
1197	66	8	t	Set Smart Refrigerator's temperature to 42	13
1198	58	24	t	Close Bathroom Window's Curtains	5
1199	2	1	t	Turn Roomba Off	18
1200	35	3	t	Start playing rock on Amazon Echo	3
1201	60	8	t	Close Smart Refrigerator's Door	13
1202	57	2	t	Turn On the AC	8
1203	13	23	t	Lock Smart Oven	13
1206	14	24	t	Close Bathroom Window	5
1207	14	25	t	Close Living Room Window	5
1208	14	25	t	Close Living Room Window	5
1209	14	25	t	Close Living Room Window	5
1210	14	25	t	Close Living Room Window	5
1211	14	25	t	Close Living Room Window	5
1212	14	25	t	Close Living Room Window	5
1213	21	2	t	Set Thermostat to 70	8
1214	14	25	t	Close Living Room Window	5
1215	14	25	t	Close Living Room Window	5
1216	14	25	t	Open Living Room Window	5
1217	14	14	t	Open Bedroom Window	5
1218	14	24	t	Open Bathroom Window	5
1219	14	25	t	Open Living Room Window	5
1220	14	14	t	Open Bedroom Window	5
1221	14	24	t	Open Bathroom Window	5
1222	57	2	t	Turn On the AC	8
1223	14	14	t	Open Bedroom Window	5
1224	14	24	t	Open Bathroom Window	5
1225	14	14	t	Open Bedroom Window	5
1226	14	24	t	Open Bathroom Window	5
1227	21	2	t	Set Thermostat to 75	8
1228	21	2	t	Set Thermostat to 75	8
1229	21	2	t	Set Thermostat to 81	8
1230	60	8	t	Close Smart Refrigerator's Door	13
1231	60	8	t	Close Smart Refrigerator's Door	13
1232	14	14	t	Open Bedroom Window	5
1233	14	14	t	Open Bedroom Window	5
1234	14	14	t	Open Bedroom Window	5
1235	14	14	t	Open Bedroom Window	5
1236	14	14	t	Open Bedroom Window	5
1237	21	2	t	Set Thermostat to 72	8
1238	21	2	t	Set Thermostat to 72	8
1239	21	2	t	Set Thermostat to 72	8
1240	21	2	t	Set Thermostat to 72	8
1241	21	2	t	Set Thermostat to 72	8
1242	21	2	t	Set Thermostat to 72	8
1243	21	2	t	Set Thermostat to 72	8
1244	21	2	t	Set Thermostat to 72	8
1245	21	2	t	Set Thermostat to 72	8
1246	21	2	t	Set Thermostat to 72	8
1247	21	2	t	Set Thermostat to 72	8
1248	58	24	t	Close Bathroom Window's Curtains	5
1249	58	24	t	Close Bathroom Window's Curtains	5
1250	58	14	t	Close Bedroom Window's Curtains	5
1251	13	13	t	Lock Front Door Lock	5
1252	2	4	t	Turn HUE Lights On	2
1253	13	13	t	Lock Front Door Lock	5
1254	2	1	t	Turn Roomba Off	18
1255	2	5	t	Turn Smart TV Off	12
\.


--
-- Name: backend_state_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backend_state_id_seq', 1255, true);


--
-- Data for Name: backend_statelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backend_statelog (id, "timestamp", is_current, cap_id, dev_id, value, param_id) FROM stdin;
\.


--
-- Name: backend_statelog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backend_statelog_id_seq', 1, false);


--
-- Data for Name: backend_timeparam; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backend_timeparam (parameter_ptr_id, mode) FROM stdin;
23	12
24	24
\.


--
-- Data for Name: backend_trigger; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backend_trigger (id, cap_id, dev_id, chan_id, pos, text) FROM stdin;
94	60	8	13	0	Smart Refrigerator's door is Open
95	60	8	13	0	Smart Refrigerator's door is Open
96	64	22	17	0	Smart Faucet's water is running
97	14	14	5	0	Window is Open
98	64	22	17	0	Smart Faucet's water is running
100	2	4	2	0	HUE Lights is On
102	28	10	10	0	Security Camera is recording
103	60	23	13	0	Smart Oven's door is Open
104	63	12	15	0	Bobby is in Kitchen
107	2	4	2	0	HUE Lights is On
108	2	4	2	0	HUE Lights is On
111	60	8	13	0	Smart Refrigerator's door is Open
112	60	8	13	0	Smart Refrigerator's door is Open
114	6	4	2	0	HUE Lights's Color is not Red
115	64	22	17	0	Smart Faucet's water is running
116	14	14	5	0	Window is Open
117	19	2	8	0	(Thermostat) The temperature is above 70
118	14	14	5	0	Window is Open
119	20	18	7	0	(Weather Sensor) It is Raining
121	63	12	15	0	Anyone is in Home
122	9	3	3	0	Amazon Echo is playing Pop
126	58	14	5	0	Window's curtains are Open
127	2	1	1	0	Roomba turns On
129	14	14	5	0	Window Opens
41	61	21	16	0	(FitBit) I am Asleep
42	2	4	2	0	HUE Lights is On
43	62	21	16	0	(FitBit) My heart rate is 22BPM
44	6	4	2	0	HUE Lights's Color is Red
130	2	4	2	0	HUE Lights turns On
46	63	12	15	0	Anyone is in Living Room
131	61	21	16	0	(FitBit) I fall asleep
132	2	4	2	0	HUE Lights turns On
133	61	21	16	0	(FitBit) I fall asleep
50	64	22	13	0	Smart Faucet's water turns On
51	63	12	15	0	Anyone enters Kitchen
134	2	4	2	0	HUE Lights turns On
54	6	4	2	1	HUE Lights's Color stops being Red
55	64	22	17	0	Smart Faucet's water is not running
56	63	12	15	0	Anyone enters Kitchen
57	63	12	15	0	Anyone enters Kitchen
58	63	12	15	0	Anyone enters Kitchen
59	63	12	15	0	Anyone enters Kitchen
135	61	21	16	0	(FitBit) I fall asleep
61	61	21	16	0	(FitBit) I am Asleep
62	6	4	2	0	HUE Lights's Color is Red
137	61	21	16	0	(FitBit) I fall asleep
138	2	1	1	0	Roomba turns On
66	60	8	13	0	Smart Refrigerator's door is Open
139	61	21	16	0	(FitBit) I fall asleep
68	57	2	8	0	The AC is Off
69	28	10	10	0	Security Camera is recording
70	28	10	10	0	Security Camera is recording
71	28	10	10	0	Security Camera is recording
73	28	10	10	0	Security Camera is recording
74	38	9	13	0	(Coffee Pot) There are <28 cups of coffee brewed
141	61	21	16	0	(FitBit) I fall asleep
142	61	21	16	0	(FitBit) I am Asleep
143	2	4	2	0	HUE Lights is On
80	60	23	13	0	Smart Oven's door is Open
81	63	12	15	0	Bobby is in Kitchen
84	61	21	16	0	(FitBit) I wake up
149	38	9	13	0	(Coffee Pot) There are 1 cups of coffee brewed
150	14	14	5	0	Window is Open
151	20	18	7	0	It is Raining
152	14	14	5	0	Window is Open
153	19	2	8	0	(Thermostat) The temperature is above 70
154	19	2	8	0	(Thermostat) The temperature is below 80
155	14	14	5	0	Window is Open
156	19	2	8	0	(Thermostat) The temperature is above 70
157	19	2	8	0	(Thermostat) The temperature is below 80
158	20	18	7	0	It is Not Raining
159	14	14	5	0	Window is Open
160	20	18	7	0	It is Raining
162	20	18	7	0	It is Raining
163	60	23	13	0	Smart Oven's door is Open
164	63	12	15	0	Bobbie is in Kitchen
165	21	2	8	0	Thermostat is set to <80 degrees
166	21	2	8	0	Thermostat is set to <80 degrees
167	19	8	13	0	(Smart Refrigerator) The temperature is below 40
168	20	18	7	0	It is Raining
169	14	14	5	0	Window is Open
170	60	8	13	0	Smart Refrigerator's door is Open
171	14	14	5	0	Window is Open
172	19	18	8	0	(Weather Sensor) The temperature is below 80
173	19	18	8	1	(Weather Sensor) The temperature is above 70
174	20	18	7	0	It is Not Raining
175	21	2	8	0	Thermostat is set to >70 degrees
176	63	12	15	0	Anyone is in Home
177	21	2	8	0	Thermostat is set to >70 degrees
178	63	12	15	0	Anyone is in Home
179	21	2	8	0	Thermostat is set to <75 degrees
180	63	12	15	0	Anyone is in Home
181	58	14	5	0	Window's curtains Open
182	9	3	3	0	Amazon Echo starts playing Pop
183	2	1	1	0	Roomba turns On
184	58	14	5	0	Window's curtains are Open
185	13	13	4	0	Smart Door Lock becomes Unlocked
186	63	12	15	0	Family Member is not in Home
187	13	13	4	0	Smart Door Lock becomes Unlocked
188	63	12	15	0	A Family Member is not in Home
189	2	1	1	0	Roomba turns On
190	63	12	15	0	A Guest is in Home
193	2	4	2	0	HUE Lights is On
195	63	12	15	0	Bobbie is in Bedroom
196	2	5	12	0	Smart TV turns On
197	55	17	9	0	(Clock) It is Nighttime
198	2	5	12	0	Smart TV turns Off
199	2	5	12	0	Smart TV is On
200	2	4	2	0	HUE Lights turns Off
204	2	5	12	0	Smart TV turns On
205	55	17	9	0	It is Nighttime
209	28	10	10	0	Security Camera is recording
210	2	4	2	0	HUE Lights turns On
211	2	4	2	0	HUE Lights turns On
214	2	4	2	1	HUE Lights turns On
216	2	4	2	0	HUE Lights turns On
217	2	4	2	0	HUE Lights turns On
219	14	25	5	0	Living Room Window Opens
220	20	18	7	1	It is Raining
222	14	25	5	1	Living Room Window is Open
223	14	24	5	0	Bathroom Window Closes
224	14	14	5	1	Bedroom Window is Closed
225	14	25	5	2	Living Room Window is Closed
226	14	14	5	0	Bedroom Window Closes
227	14	24	5	1	Bathroom Window is Closed
228	14	25	5	2	Living Room Window is Closed
229	14	25	5	0	Living Room Window Closes
230	14	24	5	1	Bathroom Window is Closed
231	14	14	5	2	Bedroom Window is Closed
232	60	23	13	0	Smart Oven's door Opens
233	63	12	15	1	Bobbie is in Kitchen
234	63	12	15	0	Bobbie enters Kitchen
235	60	23	13	1	Smart Oven's door is Open
236	19	2	8	0	(Thermostat) The temperature goes above 80
237	19	8	13	0	(Smart Refrigerator) The temperature falls below 40
238	51	11	14	0	It becomes true that "Smart Faucet's water is not running" was last in effect 1m  ago
239	51	11	14	0	It becomes true that "Smart Faucet's water is not running" was last in effect 5m  ago
240	19	2	8	0	(Thermostat) The temperature falls below 80
241	19	2	8	1	(Thermostat) The temperature is above 70
242	18	18	7	2	(Weather Sensor) The weather is Clear
243	14	14	5	3	Bedroom Window is Closed
244	19	2	8	0	(Thermostat) The temperature goes above 70
245	19	2	8	1	(Thermostat) The temperature is below 80
246	18	18	7	2	(Weather Sensor) The weather is Clear
247	14	14	5	3	Bedroom Window is Closed
248	18	18	7	0	(Weather Sensor) The weather changes to Clear
249	19	2	8	1	(Thermostat) The temperature is below 80
250	19	2	8	2	(Thermostat) The temperature is above 70
251	14	14	5	3	Bedroom Window is Closed
252	14	14	5	0	Bedroom Window Closes
253	19	2	8	1	(Thermostat) The temperature is below 80
254	19	2	8	2	(Thermostat) The temperature is above 70
255	18	18	7	3	(Weather Sensor) The weather is Clear
256	2	1	18	0	Roomba is On
257	63	12	15	0	A Guest is in Home
259	2	1	18	1	Roomba is On
260	2	1	18	0	Roomba is On
261	63	12	15	0	Anyone is in Home
262	2	1	18	0	Roomba is On
263	63	12	15	0	Anyone is in Home
265	63	12	15	0	Anyone is in Home
267	2	1	18	0	Roomba is On
269	2	4	2	0	HUE Lights is On
271	2	4	2	0	HUE Lights is On
273	2	4	2	0	HUE Lights is On
275	63	12	15	0	A Family Member is in Home
280	14	24	5	1	Bathroom Window is Closed
281	14	14	5	2	Bedroom Window is Closed
283	63	12	15	1	Bobbie is in Kitchen
288	19	8	13	0	(Smart Refrigerator) The temperature becomes 40
291	52	11	14	1	"(FitBit) I fall asleep" last happened >30m  ago
292	2	5	12	2	Smart TV is On
294	19	18	8	1	(Weather Sensor) The temperature is below 80
295	20	18	7	2	It is Not Raining
296	14	14	5	3	Bedroom Window is Closed
299	58	14	5	1	Bedroom Window's curtains are Open
301	61	21	16	1	(FitBit) I am Asleep
303	52	11	14	1	"A Guest enters Home" last happened <3h  ago
305	2	5	12	1	Smart TV is On
307	60	8	13	0	Smart Refrigerator's door is Open
309	63	12	15	0	Anyone is in Home
313	61	21	16	0	(FitBit) I am Asleep
315	63	12	15	0	A Guest is in Home
427	2	1	18	1	Roomba is On
317	61	21	16	0	(FitBit) I am Asleep
319	58	14	5	0	Bedroom Window's curtains are Open
324	19	18	8	0	(Weather Sensor) The temperature is above 60
325	19	18	8	0	(Weather Sensor) The temperature is below 80
326	20	18	7	0	It is Not Raining
339	2	23	13	0	Smart Oven is On
342	63	12	15	0	A Guest is in Home
344	14	14	5	0	Bedroom Window is Closed
345	14	25	5	0	Living Room Window is Closed
349	63	12	15	0	Anyone is in Home
351	63	12	15	0	Anyone is in Home
354	19	18	8	0	(Weather Sensor) The temperature is above 80
356	37	5	12	1	adam is playing on Smart TV
357	61	21	16	0	(FitBit) I am Asleep
358	2	1	18	0	Roomba is On
365	2	1	18	0	Roomba is Off
367	2	1	18	0	Roomba is On
371	65	23	13	0	Smart Oven's temperature is above below 5 degrees
372	60	23	13	0	Smart Oven's door is Open
381	50	11	14	0	It becomes true that "Smart Faucet's water turns On" has occurred >1 times in the last 15s 
384	9	3	3	0	Amazon Echo is not playing Pop
386	14	25	5	1	Living Room Window is Closed
387	14	24	5	2	Bathroom Window is Open
389	60	8	13	0	Smart Refrigerator's door is Open
391	2	1	18	0	Roomba is On
398	61	21	16	0	(FitBit) I am Asleep
400	2	1	18	0	Roomba is On
403	64	22	17	0	Smart Faucet's water is not running
404	64	22	17	0	Smart Faucet's water is not running
406	14	14	5	0	Bedroom Window is Closed
407	14	25	5	0	Living Room Window is Closed
409	14	24	5	0	Bathroom Window is Closed
410	14	25	5	0	Living Room Window is Closed
412	64	22	17	0	Smart Faucet's water is not running
414	14	24	5	0	Bathroom Window is Closed
415	14	14	5	0	Bedroom Window is Closed
416	2	1	18	0	Roomba is On
417	25	17	9	0	(Clock) The time is{time/!=| not}{time/>| after}{time/<| before} 15:00
418	25	17	9	0	(Clock) The time is{time/!=| not}{time/>| after}{time/<| before} 00:00
419	19	2	8	0	(Thermostat) The temperature is below 80
421	25	17	9	0	(Clock) The time is{time/!=| not}{time/>| after}{time/<| before} 15:00
422	25	17	9	1	(Clock) The time is{time/!=| not}{time/>| after}{time/<| before} 00:00
423	19	2	8	0	(Thermostat) The temperature is below 80
425	58	24	5	0	Bathroom Window's curtains are Closed
429	19	2	8	0	(Thermostat) The temperature goes above 80
430	19	2	8	0	(Thermostat) The temperature is 80
431	19	2	8	0	(Thermostat) The temperature goes above 80
432	19	2	8	0	(Thermostat) The temperature is 80
434	57	2	8	0	The AC is On
436	63	12	15	0	A Guest is in Home
438	63	12	6	0	Someone other than Anyone is not in Home
440	19	2	8	0	(Thermostat) The temperature is 80
442	61	21	16	0	(FitBit) I am Asleep
445	58	24	5	0	Bathroom Window's curtains are Closed
448	19	2	8	0	(Thermostat) The temperature is above 80
449	63	12	15	0	Anyone is not in Home
458	60	8	13	0	Smart Refrigerator's door is Open
461	13	13	4	0	Front Door Lock is Locked
462	61	21	16	0	(FitBit) I am Asleep
466	14	14	5	0	Bedroom Window is Open
467	19	18	8	0	(Weather Sensor) The temperature is above 60
468	19	18	8	0	(Weather Sensor) The temperature is below 80
472	19	18	8	0	(Weather Sensor) The temperature is above 60
473	19	18	8	0	(Weather Sensor) The temperature is below 80
474	20	18	7	0	It is Not Raining
483	64	22	17	0	Smart Faucet's water is running
491	14	14	5	1	Bedroom Window is Closed
493	14	24	5	1	Bathroom Window is Closed
495	14	14	5	1	Bedroom Window is Closed
496	60	8	13	0	Smart Refrigerator's door Opens
497	52	11	14	1	It becomes true that "Smart Refrigerator's door Opens" last happened {time/=|exactly} 2m  ago
498	21	2	8	0	Thermostat becomes set to 81 degrees
499	63	12	15	1	Anyone is in Home
500	14	25	5	2	Living Room Window is Closed
501	14	14	5	3	Bedroom Window is Closed
503	52	11	14	1	It becomes true that "Smart Refrigerator's door Opens" last happened {time/=|exactly} 2m  ago
505	63	12	15	1	Anyone is in Home
506	14	25	5	2	Living Room Window is Closed
507	14	14	5	3	Bedroom Window is Closed
509	61	21	6	0	(FitBit) I am Asleep
511	9	3	3	0	Amazon Echo is playing Pop
513	64	22	17	0	Smart Faucet's water is running
515	61	21	6	0	(FitBit) I am Asleep
525	63	12	6	0	Anyone is in Bedroom
532	63	12	15	1	Bobbie is in Kitchen
533	63	12	15	2	A Family Member is not in Kitchen
537	19	18	6	0	(Weather Sensor) The temperature is above 59
539	19	18	6	0	(Weather Sensor) The temperature is below 81
541	60	8	13	0	Smart Refrigerator's door is Open
543	19	8	13	0	(Smart Refrigerator) The temperature is below 30
545	14	14	5	0	Bedroom Window Opens
546	18	18	7	0	(Weather Sensor) The weather is Raining
550	18	18	7	0	(Weather Sensor) The weather is not Raining
552	2	5	12	1	Smart TV is On
553	14	14	5	0	Bedroom Window Closes
554	19	18	6	0	(Weather Sensor) The temperature is 70
556	64	22	17	0	Smart Faucet's water is running
557	14	14	5	0	Bedroom Window Closes
558	19	18	6	0	(Weather Sensor) The temperature is above 70
561	19	18	6	0	(Weather Sensor) The temperature is above 80
564	19	18	6	0	(Weather Sensor) The temperature is below 60
568	20	18	7	0	It is Raining
570	63	12	15	1	Anyone is not in Home
572	63	12	15	1	Anyone is in Home
574	19	18	8	0	(Weather Sensor) The temperature is below 67
576	19	18	8	0	(Weather Sensor) The temperature is below 67
580	2	1	18	0	Roomba is On
583	63	12	6	1	Anyone is in Home
585	2	1	18	0	Roomba is On
587	2	1	18	0	Roomba is On
589	2	1	18	0	Roomba is On
593	13	13	5	0	Front Door Lock becomes Unlocked
594	63	12	15	1	A Family Member is not in Living Room
595	27	17	9	2	Clock's Alarm is not going off
600	52	11	14	1	"Smart Faucet's water turns On" last happened more than{time/=|exactly} 14s  ago
603	14	24	5	0	Bathroom Window is Closed
604	14	14	5	0	Bedroom Window is Closed
609	13	13	5	0	Front Door Lock becomes Unlocked
610	63	12	15	1	A Family Member is not in Living Room
611	27	17	9	2	Clock's Alarm is not going off
613	2	5	12	1	Smart TV is On
614	25	17	9	2	(Clock) The time is{time/!=| not}{time/>| after}{time/<| before} 23:00
616	63	12	15	1	A Family Member is not in Living Room
617	27	17	9	2	Clock's Alarm is going off
619	63	12	15	1	Someone other than Bobbie is not in Kitchen
621	2	1	18	1	Roomba is On
623	2	1	18	1	Roomba is On
626	2	1	18	1	Roomba is On
637	19	18	8	0	(Weather Sensor) The temperature is above 80
640	14	14	5	1	Bedroom Window is Closed
641	14	25	5	2	Living Room Window is Closed
643	19	18	8	0	(Weather Sensor) The temperature is below 60
645	14	24	5	1	Bathroom Window is Closed
646	14	25	5	2	Living Room Window is Closed
648	20	18	7	0	It is Raining
650	66	8	13	0	Smart Refrigerator's temperature is set below 40 degrees
652	14	14	5	1	Bedroom Window is Closed
653	14	24	5	2	Bathroom Window is Closed
656	2	23	13	0	Smart Oven is On
658	2	1	18	1	Roomba is On
659	63	12	15	2	A Guest is in Home
660	55	17	9	3	It is Daytime
665	55	17	9	1	It is Daytime
666	2	1	18	2	Roomba is On
673	61	21	6	0	(FitBit) I am Asleep
676	57	2	8	1	The AC is On
679	25	17	9	1	(Clock) The time is{time/!=| not}{time/>| after}{time/<| before} 23:00
680	2	5	12	0	Smart TV turns On
682	25	17	9	1	(Clock) The time is{time/!=| not}{time/>| after}{time/<| before} 23:50
684	63	12	6	0	Bobbie is in Kitchen
688	63	12	6	0	A Family Member is in Home
690	13	23	13	0	Smart Oven is Locked
692	63	12	6	0	Anyone is not in Home
696	63	12	15	1	Anyone is not in Home
697	19	18	8	2	(Weather Sensor) The temperature is above 75
699	25	17	9	1	(Clock) The time is{time/!=| not}{time/>| after}{time/<| before} 23:45
701	57	2	8	1	The AC is On
705	25	17	9	1	(Clock) The time is{time/!=| not}{time/>| after}{time/<| before} 23:45
707	60	8	13	0	Smart Refrigerator's door is Open
709	65	23	13	1	Smart Oven's temperature is above below 300 degrees
710	2	1	18	0	Roomba is On
711	63	12	6	0	A Guest is in Home
713	63	12	6	0	A Guest is in Home
715	66	8	13	1	Smart Refrigerator's temperature is set above 45 degrees
717	60	23	13	0	Smart Oven's door is Open
718	63	12	15	0	Bobbie is in Kitchen
724	63	12	15	0	Bobbie is in Kitchen
725	2	5	12	0	Smart TV is Off
726	61	21	6	0	(FitBit) I am Asleep
728	2	5	12	0	Smart TV is Off
729	61	21	6	0	(FitBit) I am Asleep
732	61	21	6	0	(FitBit) I am Awake
734	14	14	5	1	Bedroom Window is Closed
735	14	25	5	2	Living Room Window is Closed
736	2	5	12	0	Smart TV is Off
737	61	21	6	0	(FitBit) I am Asleep
739	61	21	6	0	(FitBit) I am Asleep
741	61	21	16	0	(FitBit) I am Asleep
745	61	21	6	0	(FitBit) I am Asleep
755	2	7	3	0	Speakers is On
756	9	3	3	0	Amazon Echo is playing Pop
758	63	12	6	0	Anyone is in Home
760	63	12	6	0	Anyone is in Home
762	63	12	15	0	Anyone is in Home
764	64	22	17	0	Smart Faucet's water is running
766	66	8	13	0	Smart Refrigerator's temperature is set below 40 degrees
768	19	2	8	0	(Thermostat) The temperature goes above 80
770	19	8	13	0	(Smart Refrigerator) The temperature is below 40
774	60	8	13	0	Smart Refrigerator's door is Open
779	19	2	8	0	(Thermostat) The temperature is above 80
781	55	17	9	1	It is Nighttime
784	19	2	8	0	(Thermostat) The temperature is below 60
786	20	18	7	0	It is Raining
788	14	14	5	0	Bedroom Window is Open
801	14	14	5	0	Bedroom Window is Open
802	18	18	7	0	(Weather Sensor) The weather is Clear
804	18	18	7	0	(Weather Sensor) The weather is Clear
809	52	11	14	0	"Anyone is in Home" last happened {time/=|exactly} 1s  ago
810	52	11	14	0	"Anyone is in Home" last happened more than{time/=|exactly} 3h 1s  ago
812	25	17	9	1	(Clock) The time is{time/!=| not}{time/>| after}{time/<| before} 23:59
813	61	21	16	0	(FitBit) I fall asleep
814	2	5	12	1	Smart TV is On
815	25	17	9	2	(Clock) The time is{time/!=| not}{time/>| after}{time/<| before} 23:59
817	14	14	5	0	Bedroom Window is Closed
820	14	25	5	0	Living Room Window is Closed
822	14	24	5	0	Bathroom Window is Closed
824	14	25	5	0	Living Room Window is Closed
826	14	24	5	0	Bathroom Window is Closed
828	14	14	5	0	Bedroom Window is Closed
831	2	5	12	1	Smart TV is On
832	25	17	9	2	(Clock) The time is{time/!=| not}{time/>| after}{time/<| before} 23:59
837	63	12	15	0	Anyone is in Kitchen
840	52	11	14	1	"Smart Faucet's water turns On" last happened more than{time/=|exactly} 15s  ago
846	63	12	6	1	Someone other than Bobbie is not in Kitchen
851	2	1	18	0	Roomba is On
852	63	12	15	0	A Guest is in Home
853	52	11	14	0	"A Guest is in Home" last happened less than{time/=|exactly} 3h  ago
862	55	17	9	1	It is Daytime
863	55	17	9	2	It is Nighttime
865	52	11	14	1	"Smart Refrigerator's door Opens" last happened more than{time/=|exactly} 2m  ago
867	2	5	12	1	Smart TV is On
868	49	11	14	2	"Smart TV is On" was active 30m  ago
876	2	1	18	1	Roomba is On
878	2	5	12	1	Smart TV is On
879	52	11	14	2	"(FitBit) I fall asleep" last happened more than{time/=|exactly} 30m  ago
881	52	11	14	1	"Roomba turns Off" last happened more than{time/=|exactly} 3h  ago
888	14	14	5	1	Bedroom Window is Open
890	14	14	5	1	Bedroom Window is Open
893	14	14	5	1	Bedroom Window is Open
894	19	2	8	0	(Thermostat) The temperature falls below 80
895	14	14	5	1	Bedroom Window is Closed
897	14	14	5	1	Bedroom Window is Closed
898	20	18	7	2	It is Not Raining
899	19	2	8	0	(Thermostat) The temperature goes above 60
900	20	18	7	1	It is Not Raining
902	20	18	7	1	It is Not Raining
903	14	14	5	2	Bedroom Window is Closed
907	52	11	14	1	"Smart Faucet's water turns On" last happened {time/=|exactly} 15s  ago
909	2	1	18	1	Roomba is On
911	2	23	13	1	Smart Oven is On
916	2	23	13	1	Smart Oven is On
918	2	23	13	1	Smart Oven is On
920	52	11	14	1	"Smart Refrigerator's door Opens" last happened {time/=|exactly} 2m  ago
922	55	17	9	1	It is Nighttime
924	20	18	7	1	It is Not Raining
925	19	2	8	2	(Thermostat) The temperature is below 80
927	52	11	14	1	"Smart Faucet's water turns On" last happened {time/=|exactly} 15s  ago
930	58	14	5	1	Bedroom Window's curtains are Open
931	2	1	18	2	Roomba is On
933	61	21	16	1	(FitBit) I am Asleep
935	64	22	17	0	Smart Faucet's water is running
945	64	22	17	0	Smart Faucet's water is not running
947	2	4	2	0	HUE Lights is On
955	63	12	15	0	Anyone is in Bathroom
957	14	24	5	1	Bathroom Window is Closed
958	14	25	5	2	Living Room Window is Closed
961	63	12	15	0	Anyone is in Home
963	14	14	5	0	Bedroom Window Closes
964	19	18	8	1	(Weather Sensor) The temperature is above 60
965	19	18	8	2	(Weather Sensor) The temperature is below 80
966	20	18	7	3	It is Not Raining
968	19	18	8	1	(Weather Sensor) The temperature is above 60
969	19	18	8	2	(Weather Sensor) The temperature is below 80
970	20	18	7	3	It is Not Raining
975	14	14	5	1	Bedroom Window is Closed
978	14	25	5	1	Living Room Window is Closed
980	14	25	5	1	Living Room Window is Closed
982	2	23	13	0	Smart Oven is On
984	14	14	5	0	Bedroom Window is Closed
987	14	14	5	0	Bedroom Window Opens
988	19	2	8	0	(Thermostat) The temperature is above 80
990	2	5	12	1	Smart TV is On
991	52	11	14	2	"(FitBit) I Fall Asleep" last happened more than 30m  ago
998	19	18	8	0	(Weather Sensor) The temperature is below 60
999	14	14	5	0	Bedroom Window Opens
1000	19	18	8	1	(Weather Sensor) The temperature is below 60
1002	19	18	8	1	(Weather Sensor) The temperature is below 60
1004	19	18	8	1	(Weather Sensor) The temperature is below 60
1006	19	18	8	0	(Weather Sensor) The temperature is above 80
1009	20	18	7	0	It is Raining
1011	55	17	9	1	It is Nighttime
1012	66	8	13	0	Smart Refrigerator's temperature is set above 40 degrees
1014	9	3	3	0	Amazon Echo starts playing Pop
1018	55	17	9	1	It is Nighttime
1020	58	14	5	1	Bedroom Window's curtains are Open
1021	58	25	5	2	Living Room Window's curtains are Open
1026	64	22	17	0	Smart Faucet's water is not running
1028	58	25	5	1	Living Room Window's curtains are Open
1029	64	22	17	0	Smart Faucet's water is not running
1031	13	13	5	0	Front Door Lock Locks
1032	15	10	6	1	Security Camera detects motion
1033	13	13	4	2	Front Door Lock is Locked
1036	60	8	13	1	Smart Refrigerator's door is Open
1037	60	8	13	2	Smart Refrigerator's door is Open
1045	61	21	16	0	(FitBit) I am Asleep
1048	63	12	15	0	Bobbie is in Kitchen
1053	14	24	5	1	Bathroom Window is Closed
1061	52	11	14	1	"Smart Refrigerator's door Opens" last happened more than 2m  ago
1065	14	14	5	1	Bedroom Window is Closed
1066	14	25	5	2	Living Room Window is Closed
1069	63	12	6	0	Someone other than A Guest is not in Home
1073	2	5	12	0	Smart TV is On
1074	2	5	12	1	Smart TV is Off
1075	52	11	14	0	"(FitBit) I am Asleep" last happened more than 30m  ago
1076	14	24	5	0	Bathroom Window Closes
1077	14	14	5	1	Bedroom Window is Closed
1078	14	25	5	2	Living Room Window is Closed
1080	58	25	5	0	Living Room Window's curtains are Open
1082	2	23	13	1	Smart Oven is On
1084	63	12	6	0	A Guest is in Home
1086	14	14	5	1	Bedroom Window is Closed
1087	14	25	5	2	Living Room Window is Closed
1089	2	1	18	1	Roomba is Off
1369	2	5	12	1	Smart TV is On
1090	63	12	6	2	A Guest is not in Home
1092	58	14	5	0	Bedroom Window's curtains are Open
1094	58	24	5	0	Bathroom Window's curtains are Open
1096	63	12	6	0	A Family Member is in Home
1100	15	10	6	1	Security Camera detects motion
1101	13	13	4	2	Front Door Lock is Locked
1103	2	5	12	1	Smart TV is On
1106	61	21	16	0	(FitBit) I am Asleep
1108	2	1	18	1	Roomba is On
1112	19	2	8	1	(Thermostat) The temperature is 70
1114	61	21	16	0	(FitBit) I am Asleep
1117	19	2	8	0	(Thermostat) The temperature is above 80
1120	61	21	6	0	(FitBit) I am Asleep
1127	2	1	18	0	Roomba is On
1133	35	3	3	1	This  is playing on Amazon Echo
1135	19	18	8	0	(Weather Sensor) The temperature is above 80
1136	14	14	5	0	Bedroom Window Opens
1137	19	2	8	0	(Thermostat) The temperature is 80
1139	2	5	1	1	Smart TV is On
1140	61	21	6	2	(FitBit) I am Asleep
1141	2	5	12	3	Smart TV is On
1143	20	18	7	0	It is Raining
1144	14	14	5	0	Bedroom Window Opens
1145	19	2	8	0	(Thermostat) The temperature is above 80
1146	19	8	13	0	(Smart Refrigerator) The temperature is below 40
1149	19	18	8	0	(Weather Sensor) The temperature is below 60
1150	14	14	5	0	Bedroom Window Opens
1151	19	2	8	0	(Thermostat) The temperature is below 60
1154	20	18	7	0	It is Raining
1157	63	12	15	1	Bobbie is in Kitchen
1159	19	18	8	0	(Weather Sensor) The temperature is below 60
1161	19	18	8	0	(Weather Sensor) The temperature is above 80
1165	58	14	5	1	Bedroom Window's curtains are Closed
1173	60	8	13	0	Smart Refrigerator's door is Open
1174	51	11	14	0	"undefined" was last in effect exactly 2m  ago
1176	21	2	8	0	Thermostat is set to 75 degrees
1177	63	12	15	0	Anyone is not in Home
1181	63	12	15	0	Anyone is not in Home
1188	21	2	8	0	Thermostat's temperature becomes set to 70 degrees
1189	63	12	15	0	Anyone is in Home
1192	63	12	15	0	Anyone is in Home
1196	55	17	9	0	It is Nighttime
1198	19	2	8	0	(Thermostat) The temperature is above 80
1203	61	21	16	1	(FitBit) I am Asleep
1205	60	8	13	1	Smart Refrigerator's door is Open
1208	2	4	2	0	HUE Lights is Off
1210	20	18	7	0	It is Raining
1212	19	8	13	0	(Smart Refrigerator) The temperature is above 48
1213	14	24	5	0	Bathroom Window is Open
1214	19	18	8	0	(Weather Sensor) The temperature is 80
1217	25	17	9	1	(Clock) The time is after 00:00
1227	2	4	2	0	HUE Lights is Off
1229	19	18	8	0	(Weather Sensor) The temperature is below 80
1230	19	18	8	0	(Weather Sensor) The temperature is above 60
1231	20	18	7	0	It is Not Raining
1233	63	12	6	1	Anyone is in Home
1241	2	5	1	0	Smart TV is On
1251	63	12	15	0	Anyone is in Home
1252	14	14	5	0	Bedroom Window Closes
1253	20	18	7	0	It is Raining
1255	20	18	7	0	It is Raining
1256	13	14	5	0	Bedroom Window Locks
1257	19	18	8	0	(Weather Sensor) The temperature is above 80
1259	19	18	8	0	(Weather Sensor) The temperature is below 60
1262	19	18	8	0	(Weather Sensor) The temperature is above 80
1264	63	12	6	1	Bobbie is in Kitchen
1267	55	17	9	0	It is Nighttime
1270	55	17	9	0	It is Nighttime
1272	58	24	5	0	Bathroom Window's curtains are Open
1278	19	2	8	1	(Thermostat) The temperature is below 80
1279	20	18	7	2	It is Not Raining
1287	63	12	6	0	Anyone is not in Home
1289	2	23	13	0	Smart Oven is On
1292	2	23	13	0	Smart Oven is On
1294	25	17	9	0	(Clock) The time is after 12:00
1295	2	1	18	0	Roomba turns Off
1296	25	17	9	0	(Clock) The time is before 19:00
1298	60	8	13	1	Smart Refrigerator's door is Open
1300	25	17	9	0	(Clock) The time is after 20:00
1302	63	12	15	0	A Guest is in Home
1303	13	13	4	0	Front Door Lock is Locked
1304	55	17	9	0	It is Nighttime
1306	57	2	8	0	The AC is On
1310	63	12	15	0	Anyone is not in Home
1312	65	23	13	0	Smart Oven's temperature is above below 80 degrees
1315	64	22	17	1	Smart Faucet's water is running
1317	20	18	7	0	It is Not Raining
1320	19	18	8	0	(Weather Sensor) The temperature is below 70
1321	20	18	7	0	It is Not Raining
1324	2	1	18	0	Roomba is Off
1337	61	21	6	0	(FitBit) I am Asleep
1340	57	2	8	0	The AC is On
1342	19	2	8	0	(Thermostat) The temperature is above 80
1344	63	12	6	0	Anyone is not in Home
1352	49	11	17	1	"Smart Faucet's water is running" was active 15s  ago
1353	51	11	14	2	It becomes true that "Smart Faucet's water is not running" was last in effect exactly 16s  ago
1355	20	18	7	0	It is Raining
1357	55	17	9	0	It is Nighttime
1359	64	22	17	1	Smart Faucet's water is running
1366	19	18	8	0	(Weather Sensor) The temperature is below 80
1367	21	2	8	0	Thermostat is set above 60 degrees
1376	60	23	13	0	Smart Oven's door Opens
1377	2	23	13	1	Smart Oven is On
1379	2	23	13	1	Smart Oven is On
1381	2	23	13	1	Smart Oven is On
1382	63	12	15	0	A Family Member Enters Bedroom
1383	55	17	9	1	It is Nighttime
1385	55	17	9	1	It is Nighttime
1390	19	2	8	1	(Thermostat) The temperature is below 80
1392	19	2	8	1	(Thermostat) The temperature is above 60
1394	2	1	18	1	Roomba is On
1396	19	18	8	1	(Weather Sensor) The temperature is above 60
1397	19	18	8	2	(Weather Sensor) The temperature is below 80
1401	19	18	8	1	(Weather Sensor) The temperature is above 60
1402	19	18	8	2	(Weather Sensor) The temperature is below 80
1405	2	1	18	1	Roomba is On
1409	57	2	8	1	The AC is Off
1410	14	25	5	0	Living Room Window Closes
1411	63	12	15	1	A Family Member is in Home
1413	63	12	15	1	A Family Member is in Home
1414	63	12	6	0	Someone other than Alice Enters Kitchen
1421	14	14	5	1	Bedroom Window is Closed
1422	14	25	5	2	Living Room Window is Closed
1425	14	24	5	1	Bathroom Window is Closed
1426	14	25	5	2	Living Room Window is Closed
1427	14	25	5	0	Living Room Window Closes
1428	14	24	5	1	Bathroom Window is Closed
1429	14	14	5	2	Bedroom Window is Closed
1431	14	24	5	1	Bathroom Window is Closed
1432	14	14	5	2	Bedroom Window is Closed
1433	14	24	5	0	Bathroom Window Closes
1434	14	14	5	1	Bedroom Window is Closed
1435	14	25	5	2	Living Room Window is Closed
1437	14	24	5	1	Bathroom Window is Closed
1438	14	14	5	2	Bedroom Window is Closed
1440	14	14	5	1	Bedroom Window is Closed
1441	14	25	5	2	Living Room Window is Closed
3144	63	12	6	1	Anyone is in Home
1443	14	25	5	1	Living Room Window is Closed
1444	14	24	5	2	Bathroom Window is Closed
1445	2	5	12	0	Smart TV turns Off
1446	26	17	9	0	Clock has an Alarm set for after 
1448	19	2	8	1	(Thermostat) The temperature is above 75
1450	26	17	9	0	Clock has an Alarm set for after 
1453	19	2	8	1	(Thermostat) The temperature is below 70
1454	52	11	14	0	It becomes true that "Smart Faucet's water Turns On" last happened exactly 15s  ago
1463	52	11	14	1	"(FitBit) I Fall Asleep" last happened exactly 30m  ago
1464	19	2	8	0	(Thermostat) The temperature goes above 79 degrees
1472	52	11	14	1	"A Guest Enters Home" last happened less than 3h  ago
1474	63	12	6	0	Anyone is in Home
1476	52	11	14	1	It becomes true that "Someone other than A Family Member Enters Home" last happened exactly 3h  ago
1479	63	12	6	1	Someone other than A Family Member is not in Home
1481	52	11	14	1	"Someone other than A Family Member Enters Home" last happened exactly 3h  ago
1483	52	11	14	1	"Someone other than A Family Member Exits Home" last happened exactly 1s  ago
1485	49	11	14	1	"Smart Faucet's water is running" was active 15s  ago
1488	52	11	14	1	"Someone other than A Family Member Exits Home" last happened less than 3h  ago
1489	13	13	5	0	Front Door Lock Locks
1490	25	17	9	1	(Clock) The time is after 22:00
1491	13	13	4	2	Front Door Lock is Locked
1492	25	17	9	3	(Clock) The time is after 08:00
1493	13	13	5	4	Front Door Lock is Unlocked
1495	25	17	9	1	(Clock) The time is after 22:00
1496	13	13	4	2	Front Door Lock is Locked
1497	25	17	9	3	(Clock) The time is after 08:00
1498	13	13	5	4	Front Door Lock is Unlocked
1500	55	17	9	1	It is Daytime
1501	63	12	6	2	Someone other than A Family Member is in Home
1502	2	1	1	3	Roomba is On
1507	14	14	5	1	Bedroom Window is Closed
1508	14	25	5	2	Living Room Window is Closed
1510	18	18	7	1	(Weather Sensor) The weather is Raining
1512	19	18	8	1	(Weather Sensor) The temperature is above 80
1514	19	18	8	1	(Weather Sensor) The temperature is below 60
1525	19	18	8	0	(Weather Sensor) The temperature is above 60
1526	19	18	8	0	(Weather Sensor) The temperature is below 80
1527	20	18	7	0	It is Not Raining
1529	63	12	15	0	A Family Member is in Home
1531	14	14	5	1	Bedroom Window is Closed
1532	14	25	5	2	Living Room Window is Closed
1534	63	12	15	0	A Family Member is in Home
1538	58	25	5	0	Living Room Window's curtains are Open
1540	61	21	16	0	(FitBit) I am Asleep
1542	63	12	15	0	A Guest Enters Home
1544	14	24	5	1	Bathroom Window is Closed
1545	14	25	5	2	Living Room Window is Closed
1547	14	24	5	1	Bathroom Window is Closed
1548	14	14	5	2	Bedroom Window is Closed
1550	61	21	16	0	(FitBit) I Fall Asleep
1552	2	23	13	1	Smart Oven is On
1554	63	12	15	1	Bobbie is in Kitchen
1559	64	22	17	0	Smart Faucet's water Turns On
1561	19	18	8	1	(Weather Sensor) The temperature is above 60 degrees
1562	20	18	7	2	It is Not Raining
1564	19	18	8	1	(Weather Sensor) The temperature is above 60 degrees
1565	20	18	7	2	It is Not Raining
1567	19	18	8	1	(Weather Sensor) The temperature is below 80 degrees
1568	20	18	7	2	It is Not Raining
1570	19	18	8	1	(Weather Sensor) The temperature is above 60 degrees
1571	19	18	8	2	(Weather Sensor) The temperature is below 80 degrees
1576	2	1	18	1	Roomba is On
1578	61	21	16	1	(FitBit) I am Asleep
1580	13	13	5	1	Front Door Lock is Unlocked
1582	2	1	18	1	Roomba is On
1584	63	12	15	1	A Guest is in Home
1585	52	11	14	0	It becomes true that "(FitBit) I Fall Asleep" last happened exactly 30m  ago
1586	52	11	14	0	It becomes true that "(FitBit) I Fall Asleep" last happened exactly 30m  ago
1587	52	11	14	0	It becomes true that "(FitBit) I Fall Asleep" last happened exactly 30m  ago
1588	28	10	10	0	Security Camera starts recording
1589	2	1	18	0	Roomba turns Off
1590	20	18	7	0	It starts raining
1591	20	18	7	0	It starts raining
1592	14	25	5	1	Living Room Window is Open
1595	57	2	8	0	The AC turns On
1596	21	2	8	0	Thermostat is set to 80 degrees
1598	21	2	8	0	Thermostat is set to 80 degrees
1600	20	18	7	1	It is Not Raining
1601	63	12	15	0	Anyone Enters Home
1604	63	12	15	0	A Guest Enters Home
1605	25	17	9	1	(Clock) The time is after 17:00
1606	25	17	9	2	(Clock) The time is before 20:00
1608	58	25	5	0	Living Room Window's curtains are Open
1609	63	12	15	0	A Guest Enters Home
1610	25	17	9	1	(Clock) The time is after 17:00
1611	25	17	9	2	(Clock) The time is before 20:00
1613	58	24	5	0	Bathroom Window's curtains are Open
1614	60	8	13	0	Smart Refrigerator's door Opens
1615	49	11	14	1	"Smart Refrigerator's door is Open" was active 2m  ago
1617	25	17	9	1	(Clock) The time is after 17:00
1618	25	17	9	2	(Clock) The time is before 20:00
1620	14	24	5	1	Bathroom Window is Closed
1621	14	14	5	2	Bedroom Window is Closed
1623	58	14	5	0	Bedroom Window's curtains are Open
1625	49	11	14	1	"Smart Refrigerator's door is Open" was active 2m  ago
1630	66	8	13	0	Smart Refrigerator's temperature is set to 40 degrees
1636	52	11	14	1	"Smart Faucet's water Turns On" last happened exactly 15s  ago
1637	14	14	5	0	Bedroom Window Opens
1638	19	2	8	0	(Thermostat) The temperature is 80 degrees
1642	19	2	8	0	(Thermostat) The temperature is 80 degrees
1646	35	3	3	0	Music is playing on Amazon Echo
1649	21	2	8	0	Thermostat's temperature becomes set to 60 degrees
1651	52	11	14	0	It becomes true that "Smart Refrigerator's door Opens" last happened more than 2m  ago
1654	61	21	16	1	(FitBit) I am Asleep
1656	61	21	6	1	(FitBit) I am Asleep
1657	13	14	4	2	Bedroom Window is Locked
1658	13	13	4	3	Front Door Lock is Locked
1662	64	22	13	1	Smart Faucet's water is not running
1663	2	1	18	2	Roomba is Off
1667	14	14	5	1	Bedroom Window is Open
1668	19	18	8	2	(Weather Sensor) The temperature is below 60 degrees
1669	14	14	5	3	Bedroom Window is Open
1671	14	14	5	0	Bedroom Window is Closed
1673	63	12	6	1	Anyone is not in Kitchen
1677	19	18	8	0	(Weather Sensor) The temperature is 80 degrees
1680	19	18	8	0	(Weather Sensor) The temperature is 60 degrees
1682	60	8	13	1	Smart Refrigerator's door is Open
1686	8	5	12	1	Smart TV's Volume is 30
1690	19	2	8	0	(Thermostat) The temperature goes above 59 degrees
1691	19	2	8	1	(Thermostat) The temperature is below 81 degrees
1692	20	18	7	2	It is Not Raining
1696	52	11	14	1	"Smart Faucet's water Turns On" last happened exactly 15s  ago
1698	63	12	15	0	Someone other than Alice is not in Kitchen
1702	2	1	18	1	Roomba is On
1703	63	12	6	2	Someone other than A Family Member is not in Home
1711	20	18	7	0	It is Raining
1713	19	2	8	1	(Thermostat) The temperature is below 81 degrees
1714	20	18	7	2	It is Not Raining
1716	58	25	5	0	Living Room Window's curtains are Open
1719	63	12	15	1	Anyone is not in Kitchen
1722	2	1	1	1	Roomba is On
1725	2	1	1	1	Roomba is On
1728	2	23	13	0	Smart Oven turns On
1738	63	12	6	0	Bobbie is in Kitchen
1745	58	25	5	0	Living Room Window's curtains Close
1746	58	14	5	1	Bedroom Window's curtains are Closed
1747	58	24	5	2	Bathroom Window's curtains are Closed
1748	58	24	5	3	Bathroom Window's curtains are Closed
1751	20	18	7	1	It is Not Raining
1753	57	2	8	1	The AC is Off
1758	63	12	15	0	Someone other than Anyone is in Home
1761	20	18	7	1	It is Not Raining
1765	63	12	15	1	A Family Member is in Kitchen
1767	63	12	6	0	Anyone is in Home
1770	2	1	18	1	Roomba is On
1774	19	2	8	0	(Thermostat) The temperature is 60 degrees
1783	63	12	6	0	Nobody is in Home
1786	19	18	8	0	(Weather Sensor) The temperature is 80 degrees
1789	60	8	13	0	Smart Refrigerator's door Opens
1791	63	12	6	0	Anyone is in Home
1797	19	18	8	1	(Weather Sensor) The temperature is below 81 degrees
1800	63	12	15	0	A Family Member is in Home
1802	64	22	17	0	Smart Faucet's water Turns On
1804	19	18	8	1	(Weather Sensor) The temperature is above 59 degrees
1805	64	22	17	0	Smart Faucet's water Turns On
1811	64	22	17	0	Smart Faucet's water Turns On
1813	21	2	8	0	Thermostat is set to 78 degrees
1815	19	8	13	0	(Smart Refrigerator) The temperature is below 40 degrees
1817	2	5	12	1	Smart TV is On
1818	51	11	14	2	"(FitBit) I am Asleep" was last in effect exactly 30m  ago
1821	15	10	6	0	Security Camera detects motion
1822	19	8	13	0	(Smart Refrigerator) The temperature is below 40 degrees
1825	63	12	6	0	Anyone is in Home
1827	61	21	16	0	(FitBit) I am Asleep
1831	57	2	8	1	The AC is On
1834	63	12	15	1	Anyone is in Bedroom
1837	19	8	13	0	(Smart Refrigerator) The temperature changes from 40 degrees
1843	63	12	15	0	Someone other than Nobody is in Home
1844	19	2	8	0	(Thermostat) The temperature is 73 degrees
1845	21	2	8	0	Thermostat is set to 73 degrees
1849	63	12	6	0	Someone other than A Family Member is not in Home
1850	60	23	13	0	Smart Oven's door Opens
1855	19	2	8	0	(Thermostat) The temperature goes above 75 degrees
1856	63	12	6	1	Anyone is in Home
1858	61	21	16	0	(FitBit) I Fall Asleep
1861	63	12	15	0	Anyone is not in Home
1864	63	12	6	1	Anyone is in Home
1866	63	12	15	0	Anyone is in Home
1867	63	12	15	0	Anyone is in Home
1871	58	25	5	0	Living Room Window's curtains are Open
1877	58	25	5	0	Living Room Window's curtains are Open
1879	9	3	3	0	Amazon Echo is playing Pop
1883	35	3	3	0	music stops playing on Amazon Echo
1885	14	24	5	1	Bathroom Window is Closed
1886	14	25	5	2	Living Room Window is Closed
1888	2	1	18	0	Roomba is On
1889	58	25	5	0	Living Room Window's curtains are Open
1890	63	12	6	0	Anyone Exits Home
1895	58	25	5	0	Living Room Window's curtains are Open
1896	58	14	5	0	Bedroom Window's curtains are Open
1897	58	24	5	0	Bathroom Window's curtains are Open
1901	60	23	13	0	Smart Oven's door Closes
1903	63	12	6	0	Anyone is in Home
1910	3	4	2	0	HUE Lights's Brightness is 2
1913	63	12	6	1	Someone other than Bobbie is not in Kitchen
1924	14	25	5	0	Living Room Window Opens
1926	13	13	5	0	Front Door Lock is Unlocked
1928	58	25	5	1	Living Room Window's curtains are Open
1932	63	12	6	1	Bobbie is in Kitchen
1937	49	11	14	1	"Roomba is Off" was active 1h  ago
1938	49	11	14	2	"Smart Faucet's water is running" was active 1m  ago
1944	63	12	6	1	Bobbie is in Kitchen
1948	58	14	5	0	Bedroom Window's curtains Close
1949	14	25	5	1	Living Room Window is Closed
1950	14	14	5	0	Bedroom Window Opens
1951	19	18	8	0	(Weather Sensor) The temperature is not 80 degrees
1953	64	22	17	0	Smart Faucet's water Turns On
1962	58	25	5	0	Living Room Window's curtains Close
1964	19	18	8	0	(Weather Sensor) The temperature is below 60 degrees
1965	19	18	8	0	(Weather Sensor) The temperature is above 80 degrees
1969	19	2	8	0	(Thermostat) The temperature is above 80 degrees
1970	19	2	8	0	(Thermostat) The temperature is below 60 degrees
1974	19	18	8	0	(Weather Sensor) The temperature is below 60 degrees
1976	14	25	5	1	Living Room Window is Closed
1978	58	14	5	1	Bedroom Window's curtains are Closed
1984	19	2	8	0	(Thermostat) The temperature is above 80 degrees
1985	19	2	8	0	(Thermostat) The temperature is below 60 degrees
1994	2	5	12	0	Smart TV turns On
1996	63	12	15	0	Alice is not in Home
1997	64	22	17	0	Smart Faucet's water Turns On
1998	64	22	17	1	Smart Faucet's water is not running
1999	52	11	14	2	"Smart Faucet's water Turns On" last happened exactly 15s  ago
2001	55	17	9	0	It is Nighttime
2003	64	22	17	1	Smart Faucet's water is not running
2004	52	11	14	2	"Smart Faucet's water Turns On" last happened exactly 15s  ago
2005	19	2	8	0	(Thermostat) The temperature goes above 80 degrees
2010	14	24	5	0	Bathroom Window is Closed
2011	14	25	5	0	Living Room Window is Closed
2014	14	24	5	0	Bathroom Window is Closed
2309	63	12	15	0	A Guest Enters Home
2313	63	12	15	0	A Family Member is in Living Room
2314	55	17	9	0	It is Nighttime
2015	14	14	5	0	Bedroom Window is Closed
2017	61	21	6	0	(FitBit) I Fall Asleep
2019	61	21	16	0	(FitBit) I Fall Asleep
2027	50	11	14	1	"Smart Refrigerator's door Opens" has occurred >1 times in the last 2m 
2028	64	22	13	0	Smart Faucet's water Turns Off
2029	64	22	13	0	Smart Faucet's water Turns Off
2030	64	22	13	0	Smart Faucet's water Turns Off
2031	64	22	13	0	Smart Faucet's water Turns Off
2033	58	14	5	0	Bedroom Window's curtains are Open
2036	49	11	14	0	It becomes true that "Roomba is Off" was active 1h  ago
2038	2	1	18	1	Roomba is On
2040	15	10	6	0	Security Camera detects motion
3447	57	2	8	2	The AC is Off
2042	2	1	18	1	Roomba is On
2044	25	17	9	0	(Clock) The time becomes 23:00
2049	15	10	6	0	Security Camera does not detect motion
2051	2	1	18	1	Roomba is On
2055	55	17	9	0	It is Nighttime
2058	55	17	9	0	It is Nighttime
2063	60	8	13	0	Smart Refrigerator's door Opens
2065	61	21	16	1	(FitBit) I am Awake
2072	13	23	13	1	Smart Oven is Unlocked
2077	60	8	13	0	Smart Refrigerator's door Opens
2081	21	2	8	0	Thermostat is set above 80 degrees
2083	21	2	8	0	Thermostat is set above 80 degrees
2085	21	2	8	0	Thermostat is set above 80 degrees
2087	65	23	13	0	Smart Oven's temperature is 125 degrees
2089	64	22	17	1	Smart Faucet's water is running
2093	19	18	8	0	(Weather Sensor) The temperature is above 80 degrees
2095	66	8	13	0	Smart Refrigerator's temperature is set to 41 degrees
2101	19	2	8	1	(Thermostat) The temperature is below 80 degrees
2104	14	14	5	0	Bedroom Window is Closed
2108	14	24	5	0	Bathroom Window is Closed
2111	14	24	5	0	Bathroom Window is Closed
2113	19	2	8	0	(Thermostat) The temperature goes above 60 degrees
2114	19	2	8	1	(Thermostat) The temperature is below 80 degrees
2116	19	2	8	1	(Thermostat) The temperature is below 80 degrees
2117	2	5	1	0	Smart TV turns Off
2118	25	17	9	0	(Clock) The time becomes 21:00
2122	14	25	5	0	Living Room Window is Closed
2124	25	17	9	0	(Clock) The time becomes 21:00
2126	14	14	5	1	Bedroom Window is Closed
2128	14	24	5	1	Bathroom Window is Closed
2129	14	14	5	2	Bedroom Window is Closed
2130	14	25	5	3	Living Room Window is Closed
2132	14	25	5	1	Living Room Window is Closed
2135	19	18	8	1	(Weather Sensor) The temperature is above 59 degrees
2136	19	18	8	2	(Weather Sensor) The temperature is below 81 degrees
2137	58	25	5	0	Living Room Window's curtains Open
2139	14	14	5	1	Bedroom Window is Closed
2142	2	1	18	0	Roomba is On
2144	2	1	18	1	Roomba is On
2147	2	1	18	0	Roomba is On
2149	2	1	18	0	Roomba is On
2151	64	22	17	0	Smart Faucet's water Turns On
2152	63	12	15	0	Bobbie Enters Kitchen
2153	2	23	13	1	Smart Oven is On
2155	2	23	13	1	Smart Oven is On
2157	18	18	7	1	(Weather Sensor) The weather is Clear
2159	2	1	18	1	Roomba is On
2162	18	18	7	1	(Weather Sensor) The weather is Clear
2164	2	1	18	1	Roomba is On
2171	9	3	3	1	Amazon Echo is playing Pop
2174	57	2	8	1	The AC is On
2175	14	24	5	0	Bathroom Window Closes
2176	14	14	5	1	Bedroom Window is Closed
2177	14	25	5	2	Living Room Window is Closed
2179	63	12	6	1	Alice is in Kitchen
2180	14	14	5	0	Bedroom Window Closes
2181	14	24	5	1	Bathroom Window is Closed
2182	14	25	5	2	Living Room Window is Closed
2183	14	25	5	0	Living Room Window Closes
2184	14	24	5	1	Bathroom Window is Closed
2185	14	14	5	2	Bedroom Window is Closed
2187	19	2	8	0	(Thermostat) The temperature is above 60 degrees
2190	14	14	5	1	Bedroom Window is Closed
2191	14	25	5	2	Living Room Window is Closed
2193	14	24	5	1	Bathroom Window is Closed
2194	14	25	5	2	Living Room Window is Closed
2196	14	24	5	1	Bathroom Window is Closed
2197	14	14	5	2	Bedroom Window is Closed
2200	19	2	8	0	(Thermostat) The temperature is above 80 degrees
2202	63	12	6	0	Anyone Enters Home
2206	19	2	8	0	(Thermostat) The temperature is above 80 degrees
2208	52	11	14	1	"Smart Refrigerator's door Opens" last happened exactly 2m  ago
2209	14	14	5	0	Bedroom Window Closes
2210	19	2	8	0	(Thermostat) The temperature is below 60 degrees
2211	9	3	3	0	Amazon Echo starts playing Pop
2214	19	2	8	0	(Thermostat) The temperature is below 59 degrees
2216	66	8	13	0	Smart Refrigerator's temperature becomes set below 40 degrees
2217	60	8	13	1	Smart Refrigerator's door is Closed
2218	58	24	5	0	Bathroom Window's curtains Open
2225	60	8	13	1	Smart Refrigerator's door is Closed
2227	60	8	13	1	Smart Refrigerator's door is Closed
2230	63	12	6	1	A Guest is in Home
2231	52	11	14	2	"A Guest Enters Home" last happened less than 3h  ago
2233	60	8	13	1	Smart Refrigerator's door is Closed
2236	14	14	5	1	Bedroom Window is Closed
2238	19	2	8	1	(Thermostat) The temperature is below 70 degrees
2239	19	2	8	2	(Thermostat) The temperature is above 75 degrees
2241	14	14	5	1	Bedroom Window is Open
2243	14	14	5	1	Bedroom Window is Open
2245	2	5	12	1	Smart TV is On
2246	15	10	6	2	Security Camera does not detect motion
2247	52	11	14	3	"(FitBit) I Fall Asleep" last happened exactly 30m  ago
2249	51	11	14	1	"Bedroom Window is Closed" was last in effect exactly  ago
2250	51	11	14	2	"Living Room Window is Closed" was last in effect exactly  ago
2252	14	14	5	1	Bedroom Window is Open
2256	63	12	6	0	A Guest is in Home
2258	19	18	8	1	(Weather Sensor) The temperature is below 80 degrees
2259	19	18	8	2	(Weather Sensor) The temperature is above 60 degrees
2260	20	18	7	3	It is Not Raining
2261	14	14	5	4	Bedroom Window is Closed
2263	19	8	13	1	(Smart Refrigerator) The temperature is above 41 degrees
2265	60	8	13	0	Smart Refrigerator's door Opens
2266	50	11	14	1	"Smart Refrigerator's door Opens" has occurred <1 times in the last 2m 
2267	9	3	3	0	Amazon Echo is not playing Pop
2279	52	11	14	1	"Smart Refrigerator's door Opens" last happened more than 2m  ago
2282	58	24	5	0	Bathroom Window's curtains Open
2295	52	11	14	1	"(FitBit) I Fall Asleep" last happened exactly 30m  ago
2297	61	21	6	0	(FitBit) I am Asleep
2299	20	18	7	1	It is Not Raining
2300	19	18	8	2	(Weather Sensor) The temperature is above 59 degrees
2301	19	18	8	3	(Weather Sensor) The temperature is below 81 degrees
2303	14	14	5	1	Bedroom Window is Closed
2305	51	11	14	1	"Smart Faucet's water is running" was last in effect exactly 15m  ago
2315	2	1	18	0	Roomba is On
2324	52	11	14	1	"Smart Refrigerator's door Closes" last happened more than 2m  ago
2332	2	1	18	1	Roomba is On
2341	2	5	12	1	Smart TV is On
2342	52	11	14	2	"(FitBit) I Fall Asleep" last happened exactly 30m  ago
2345	58	14	5	1	Bedroom Window's curtains are Open
2349	63	12	15	1	Someone other than Anyone is not in Home
2355	63	12	15	1	Nobody is not in Home
2359	63	12	15	1	Anyone is in Home
2361	14	14	5	1	Bedroom Window is Closed
2364	63	12	15	1	Anyone is in Home
2366	52	11	14	1	"Smart Faucet's water Turns On" last happened more than 15s  ago
2368	2	1	18	0	Roomba turns On
2369	58	14	5	1	Bedroom Window's curtains are Open
2370	14	25	5	2	Living Room Window is Open
2375	63	12	15	1	A Guest is in Home
2378	50	11	14	1	"Smart Faucet's water Turns On" has occurred exactly 1 times in the last 15s 
2382	13	13	4	1	Front Door Lock is Unlocked
2386	60	8	13	0	Smart Refrigerator's door Opens
2389	51	11	14	1	"Smart Refrigerator's door is Open" was last in effect exactly 2m  ago
2394	58	14	5	1	Bedroom Window's curtains are Open
2395	14	25	5	2	Living Room Window is Open
2400	63	12	6	1	A Guest is in Home
2407	2	23	13	1	Smart Oven is On
2417	2	5	12	1	Smart TV is On
2421	61	21	6	0	(FitBit) I Fall Asleep
2424	52	11	14	1	"Smart Faucet's water Turns On" last happened exactly 15s  ago
2426	61	21	16	0	(FitBit) I am Asleep
2430	63	12	15	1	Anyone is in Kitchen
2431	60	8	13	2	Smart Refrigerator's door is Open
2434	61	21	16	0	(FitBit) I Fall Asleep
2436	14	14	5	1	Bedroom Window is Open
2437	2	1	18	0	Roomba turns On
2438	2	1	18	0	Roomba turns On
2440	14	14	5	1	Bedroom Window is Open
2442	58	24	5	0	Bathroom Window's curtains Close
2444	61	21	16	0	(FitBit) I am Asleep
2447	58	25	5	1	Living Room Window's curtains are Open
2449	14	14	5	1	Bedroom Window is Closed
2450	14	25	5	2	Living Room Window is Closed
2453	58	14	5	1	Bedroom Window's curtains are Open
2455	14	14	5	1	Bedroom Window is Open
2456	2	5	1	0	Smart TV turns Off
2457	61	21	16	0	(FitBit) I am Asleep
2459	58	24	5	1	Bathroom Window's curtains are Open
2461	63	12	15	1	Bobbie is in Kitchen
2464	61	21	16	0	(FitBit) I am Asleep
2466	63	12	6	0	Anyone is in Bathroom
2468	60	8	13	0	Smart Refrigerator's door Opens
2471	19	18	8	1	(Weather Sensor) The temperature is below 80 degrees
2473	61	21	16	0	(FitBit) I am Awake
2478	9	3	3	0	Amazon Echo starts playing Pop
2480	19	2	8	1	(Thermostat) The temperature is above 60 degrees
2481	19	2	8	2	(Thermostat) The temperature is below 80 degrees
2483	63	12	15	1	Anyone is not in Home
2487	64	22	17	0	Smart Faucet's water Turns On
2489	63	12	6	0	A Family Member is in Home
2494	63	12	6	0	A Family Member is in Bedroom
2496	63	12	15	1	Someone other than Bobbie is not in Kitchen
2501	14	14	5	1	Bedroom Window is Closed
2505	14	14	5	1	Bedroom Window is Closed
2508	63	12	15	1	Anyone is not in Kitchen
2510	2	23	13	1	Smart Oven is On
2513	14	24	5	1	Bathroom Window is Closed
2515	14	25	5	1	Living Room Window is Closed
2517	2	23	13	1	Smart Oven is On
2523	14	24	5	1	Bathroom Window is Closed
2526	2	1	18	0	Roomba turns On
2527	58	24	5	1	Bathroom Window's curtains are Open
2528	58	14	5	2	Bedroom Window's curtains are Open
2529	58	25	5	3	Living Room Window's curtains are Open
2531	14	25	5	1	Living Room Window is Closed
2533	58	24	5	1	Bathroom Window's curtains are Open
2534	58	14	5	2	Bedroom Window's curtains are Open
2535	58	25	5	3	Living Room Window's curtains are Open
3448	2	1	18	0	Roomba turns Off
2538	2	1	18	1	Roomba is On
2541	2	1	18	1	Roomba is On
2545	2	1	18	1	Roomba is On
2547	57	2	8	1	The AC is Off
2549	2	23	13	1	Smart Oven is On
2552	2	23	13	1	Smart Oven is On
2555	19	18	8	0	(Weather Sensor) The temperature is 80 degrees
2560	63	12	6	0	Anyone is not in Kitchen
2562	19	18	8	0	(Weather Sensor) The temperature goes above 80 degrees
2563	14	14	5	1	Bedroom Window is Open
2567	14	14	5	1	Bedroom Window is Open
2570	63	12	6	1	Anyone is in Bedroom
2572	14	14	5	1	Bedroom Window is Open
2574	14	14	5	1	Bedroom Window is Open
2576	14	14	5	1	Bedroom Window is Open
2582	2	1	18	1	Roomba is On
2584	52	11	14	1	"A Guest Enters Home" last happened less than 3h  ago
2588	2	1	18	1	Roomba is On
2590	2	1	18	1	Roomba is On
2595	61	21	16	0	(FitBit) I am Asleep
2597	19	18	8	1	(Weather Sensor) The temperature is above 60 degrees
2598	19	18	8	2	(Weather Sensor) The temperature is below 80 degrees
2600	14	14	5	1	Bedroom Window is Closed
2601	14	25	5	2	Living Room Window is Closed
2605	14	24	5	1	Bathroom Window is Closed
2606	14	25	5	2	Living Room Window is Closed
2608	14	25	5	1	Living Room Window is Closed
2609	14	14	5	2	Bedroom Window is Closed
2611	14	24	5	1	Bathroom Window is Closed
2612	14	14	5	2	Bedroom Window is Closed
2620	52	11	14	1	"Smart Faucet's water Turns On" last happened more than 15s  ago
2621	64	22	17	2	Smart Faucet's water is running
2623	2	23	13	1	Smart Oven is On
2626	63	12	15	0	Someone other than A Family Member is in Home
2630	58	25	5	1	Living Room Window's curtains are Open
2632	58	14	5	1	Bedroom Window's curtains are Open
2634	58	24	5	1	Bathroom Window's curtains are Open
3838	2	1	18	0	Roomba turns On
2636	19	2	8	0	(Thermostat) The temperature is below 79 degrees
2637	21	2	8	0	Thermostat is set below 80 degrees
2641	64	22	17	0	Smart Faucet's water Turns On
2643	2	1	18	1	Roomba is On
2645	60	8	13	0	Smart Refrigerator's door Opens
2646	49	11	14	0	It becomes true that "Smart Refrigerator's door is Open" was active 2m  ago
2647	60	8	13	1	Smart Refrigerator's door is Open
2649	60	8	13	1	Smart Refrigerator's door is Open
2651	52	11	14	1	"Smart Faucet's water Turns On" last happened exactly 15s  ago
2662	20	18	7	1	It is Raining
2663	19	2	8	2	(Thermostat) The temperature is below 60 degrees
2664	19	2	8	3	(Thermostat) The temperature is above 80 degrees
2667	63	12	15	1	Anyone is in Home
2669	14	14	5	1	Bedroom Window is Closed
2670	14	25	5	2	Living Room Window is Closed
2674	19	18	8	1	(Weather Sensor) The temperature is above 80 degrees
2675	14	14	5	2	Bedroom Window is Open
2681	14	14	5	0	Bedroom Window Opens
2682	19	18	8	0	(Weather Sensor) The temperature is 80 degrees
2683	14	14	5	0	Bedroom Window Closes
2684	19	18	8	0	(Weather Sensor) The temperature is 60 degrees
2686	52	11	14	0	"Someone other than A Family Member is in Home" last happened less than 3h  ago
2688	19	18	8	0	(Weather Sensor) The temperature is 60 degrees
2690	19	18	8	0	(Weather Sensor) The temperature is 59 degrees
2691	14	14	5	0	Bedroom Window Closes
2692	20	18	7	0	It is Raining
2694	20	18	7	0	It is Raining
2696	19	2	8	1	(Thermostat) The temperature is 88 degrees
2697	19	18	8	2	(Weather Sensor) The temperature is above 84 degrees
2698	21	2	8	3	Thermostat is set to 77 degrees
2699	19	2	8	4	(Thermostat) The temperature is 83 degrees
2702	2	1	18	1	Roomba is On
2708	9	3	3	0	Amazon Echo stops playing Pop
2711	58	14	5	1	Bedroom Window's curtains are Open
2712	58	24	5	2	Bathroom Window's curtains are Open
2722	58	14	5	1	Bedroom Window's curtains are Open
2723	58	24	5	2	Bathroom Window's curtains are Open
2729	63	12	15	0	Anyone is not in Home
2730	2	1	18	0	Roomba is On
2731	63	12	6	0	Someone other than A Guest is in Home
2735	63	12	15	0	Someone other than A Guest is in Home
2742	55	17	9	0	It is Nighttime
2743	63	12	15	0	Anyone is in Bedroom
2744	61	21	6	0	(FitBit) I am Asleep
2746	63	12	6	0	A Guest is in Home
2747	25	17	9	0	(Clock) The time is after 17:00
2749	63	12	6	0	Someone other than A Family Member is in Home
2752	14	14	5	0	Bedroom Window is Closed
2753	14	25	5	0	Living Room Window is Closed
2755	14	24	5	0	Bathroom Window is Closed
2756	14	25	5	0	Living Room Window is Closed
2758	14	14	5	0	Bedroom Window is Closed
2759	14	24	5	0	Bathroom Window is Closed
2767	64	22	17	0	Smart Faucet's water Turns On
2769	64	22	17	0	Smart Faucet's water Turns On
2771	64	22	17	0	Smart Faucet's water Turns On
2773	64	22	17	0	Smart Faucet's water Turns On
2775	64	22	17	0	Smart Faucet's water Turns On
2777	64	22	17	0	Smart Faucet's water Turns On
2779	64	22	17	0	Smart Faucet's water Turns On
2781	64	22	17	0	Smart Faucet's water Turns On
2783	64	22	17	0	Smart Faucet's water Turns On
2785	64	22	17	0	Smart Faucet's water Turns On
2787	64	22	17	0	Smart Faucet's water Turns On
2789	64	22	17	0	Smart Faucet's water Turns On
2791	64	22	17	0	Smart Faucet's water Turns On
2793	64	22	17	0	Smart Faucet's water Turns On
2795	64	22	17	0	Smart Faucet's water Turns On
2797	64	22	17	0	Smart Faucet's water Turns On
2799	64	22	17	0	Smart Faucet's water Turns On
2801	64	22	17	0	Smart Faucet's water Turns On
3107	2	5	12	0	Smart TV is On
3108	55	17	9	0	It is Nighttime
3109	25	17	9	0	(Clock) The time is 22:00
3213	63	12	15	0	Anyone Enters Home
2803	64	22	17	0	Smart Faucet's water Turns On
2805	64	22	17	0	Smart Faucet's water Turns On
2807	64	22	17	0	Smart Faucet's water Turns On
2809	64	22	17	0	Smart Faucet's water Turns Off
2811	2	1	18	1	Roomba is On
2813	63	12	6	1	Bobbie is in Kitchen
2815	63	12	6	1	Bobbie is in Kitchen
2817	60	8	13	1	Smart Refrigerator's door is Open
2818	60	8	13	2	Smart Refrigerator's door is Closed
2819	60	8	13	3	Smart Refrigerator's door is Closed
2820	60	8	13	4	Smart Refrigerator's door is Closed
2821	65	23	13	0	Smart Oven's temperature goes above 100 degrees
2822	58	25	5	0	Living Room Window's curtains Close
2824	64	22	17	0	Smart Faucet's water is not running
2825	64	22	13	0	Smart Faucet's water is not running
2826	19	8	13	0	(Smart Refrigerator) The temperature becomes 39 degrees
2827	61	21	16	0	(FitBit) I Fall Asleep
2828	55	17	9	1	It is Nighttime
2831	14	24	5	0	Bathroom Window Closes
2832	14	14	5	1	Bedroom Window is Closed
2833	64	22	17	0	Smart Faucet's water is running
2834	14	14	5	0	Bedroom Window Closes
2835	14	25	5	1	Living Room Window is Closed
2836	64	22	17	0	Smart Faucet's water is running
2837	14	24	5	0	Bathroom Window Closes
2838	14	25	5	1	Living Room Window is Closed
2840	52	11	14	0	It becomes true that "(FitBit) I Fall Asleep" last happened exactly 30m  ago
2841	2	5	12	1	Smart TV is On
2842	65	23	13	0	Smart Oven's temperature goes above 100 degrees
2843	60	23	13	1	Smart Oven's door is Closed
2845	19	2	8	0	(Thermostat) The temperature becomes 81 degrees
2846	19	2	8	0	(Thermostat) The temperature becomes 80 degrees
2848	52	11	14	0	It becomes true that "Smart Faucet's water Turns On" last happened exactly 16s  ago
2851	21	2	8	0	Thermostat is set to 70 degrees
2852	63	12	15	0	Anyone is in Home
2853	49	11	14	0	It becomes true that "Bathroom Window is Closed" was active  ago
2854	14	14	5	1	Bedroom Window is Closed
2855	14	25	5	2	Living Room Window is Closed
2856	14	24	5	0	Bathroom Window Closes
2857	14	14	5	1	Bedroom Window is Closed
2858	14	25	5	2	Living Room Window is Closed
2860	14	14	5	0	Bedroom Window Closes
2861	14	24	5	1	Bathroom Window is Closed
2862	14	25	5	2	Living Room Window is Closed
2863	2	23	13	0	Smart Oven is On
2864	63	12	15	0	Someone other than Alice is in Kitchen
2865	60	23	13	0	Smart Oven's door is Open
2866	19	2	8	0	(Thermostat) The temperature becomes 78 degrees
2868	14	25	5	0	Living Room Window Closes
2869	14	24	5	1	Bathroom Window is Closed
2870	14	14	5	2	Bedroom Window is Closed
2871	14	14	5	0	Bedroom Window Closes
2872	14	24	5	1	Bathroom Window is Closed
2873	14	25	5	2	Living Room Window is Closed
2874	58	14	5	0	Bedroom Window's curtains Open
2875	63	12	6	1	Anyone is in Bedroom
2877	14	24	5	0	Bathroom Window Opens
2878	14	14	5	0	Bedroom Window is Closed
2879	19	2	8	0	(Thermostat) The temperature goes above 80 degrees
2880	52	11	14	0	It becomes true that "Someone other than Nobody Enters Home" last happened less than 3h  ago
2881	66	8	13	0	Smart Refrigerator's temperature becomes set to 41 degrees
2882	60	8	13	0	Smart Refrigerator's door is Open
2883	9	3	3	0	Amazon Echo starts playing Pop
2884	9	3	3	0	Amazon Echo starts playing Pop
2885	61	21	16	0	(FitBit) I Fall Asleep
2886	21	2	8	0	Thermostat is set to 72 degrees
2887	13	13	5	0	Front Door Lock is Locked
2888	55	17	9	0	It is Nighttime
2889	60	8	13	0	Smart Refrigerator's door Closes
2890	60	8	13	0	Smart Refrigerator's door Opens
2891	60	8	13	0	Smart Refrigerator's door Closes
2892	60	8	13	0	Smart Refrigerator's door Opens
2893	14	14	5	0	Bedroom Window is Open
2894	18	18	7	0	(Weather Sensor) The weather is not Raining
2895	18	18	7	0	(Weather Sensor) The weather is Thunderstorms
2896	18	18	7	0	(Weather Sensor) The weather is Snowing
2897	18	18	7	0	(Weather Sensor) The weather is Hailing
2898	20	18	7	0	It is Raining
2899	14	14	5	0	Bedroom Window is Open
2900	18	18	7	0	(Weather Sensor) The weather is Sunny
2901	18	18	7	0	(Weather Sensor) The weather is Clear
2902	14	14	5	0	Bedroom Window is Open
2903	18	18	7	0	(Weather Sensor) The weather is not Raining
2904	18	18	7	0	(Weather Sensor) The weather is Thunderstorms
2905	18	18	7	0	(Weather Sensor) The weather is Snowing
2906	18	18	7	0	(Weather Sensor) The weather is Hailing
2907	20	18	7	0	It is Raining
2908	66	8	13	0	Smart Refrigerator's temperature becomes set below 40 degrees
2910	15	10	6	0	Security Camera detects motion
2911	9	3	3	0	Amazon Echo starts playing Pop
2912	19	2	8	0	(Thermostat) The temperature becomes 81 degrees
2913	9	3	3	0	Amazon Echo is playing Pop
2914	21	2	8	0	Thermostat's temperature becomes set below 60 degrees
2915	19	2	8	0	(Thermostat) The temperature goes above 80 degrees
2916	9	3	3	0	Amazon Echo is playing Pop
2917	9	3	3	0	Amazon Echo is playing Pop
2918	9	3	3	0	Amazon Echo starts playing Pop
2919	64	22	17	0	Smart Faucet's water Turns Off
2920	64	22	17	0	Smart Faucet's water Turns On
2921	19	18	8	0	(Weather Sensor) The temperature goes above 80 degrees
2922	20	18	7	0	It starts raining
2923	61	21	16	0	(FitBit) I am Asleep
2924	13	13	4	0	Front Door Lock is Unlocked
2925	2	1	18	0	Roomba turns On
2926	63	12	15	0	Someone other than A Family Member is in Living Room
2927	13	13	4	0	Front Door Lock Locks
2928	55	17	9	0	It is Nighttime
2929	21	2	8	0	Thermostat is set to 72 degrees
2930	63	12	6	0	A Family Member is in Home
2931	64	22	17	0	Smart Faucet's water Turns On
2933	9	3	3	0	Amazon Echo starts playing Pop
2934	13	23	13	0	Smart Oven is Locked
2935	63	12	15	0	Bobbie is in Kitchen
2936	64	22	17	0	Smart Faucet's water Turns On
2937	49	11	14	1	"Smart Faucet's water is running" was active 15s  ago
2938	14	14	5	0	Bedroom Window is Open
2939	19	2	8	0	(Thermostat) The temperature is below 60 degrees
2940	19	2	8	0	(Thermostat) The temperature is above 80 degrees
2941	20	18	7	0	It is Raining
2942	2	1	18	0	Roomba is On
2943	63	12	15	0	Someone other than A Family Member is in Living Room
2944	52	11	14	0	"Someone other than A Family Member is in Living Room" last happened less than 3h  ago
2946	63	12	15	0	Someone other than A Family Member is in Living Room
2948	58	24	5	0	Bathroom Window's curtains are Open
2949	2	1	18	0	Roomba is On
2950	58	14	5	0	Bedroom Window's curtains are Open
2951	2	1	18	0	Roomba is On
2952	58	25	5	0	Living Room Window's curtains are Open
2953	2	1	18	0	Roomba is On
2954	58	24	5	0	Bathroom Window's curtains are Closed
2955	2	1	18	0	Roomba is On
2956	58	24	5	0	Bathroom Window's curtains are Open
2957	19	8	13	0	(Smart Refrigerator) The temperature becomes 39 degrees
2958	2	1	18	0	Roomba turns On
2959	58	25	5	1	Living Room Window's curtains are Open
2960	19	8	13	0	(Smart Refrigerator) The temperature becomes 41 degrees
2961	2	5	12	0	Smart TV is On
2962	61	21	16	0	(FitBit) I am Asleep
2963	2	23	13	0	Smart Oven turns On
2964	63	12	15	1	Bobbie is in Kitchen
2965	21	2	8	0	Thermostat is set to 73 degrees
2966	63	12	15	0	Anyone is in Home
2967	63	12	15	0	Bobbie Enters Kitchen
2968	2	23	13	1	Smart Oven is On
2969	14	14	5	0	Bedroom Window is Open
2970	19	18	8	0	(Weather Sensor) The temperature is above 60 degrees
2971	18	18	7	1	(Weather Sensor) The weather is not Raining
2972	19	18	8	0	(Weather Sensor) The temperature is below 80 degrees
2973	2	1	18	0	Roomba is On
2974	58	24	5	0	Bathroom Window's curtains are Open
2975	58	14	5	0	Bedroom Window's curtains are Open
2976	58	25	5	0	Living Room Window's curtains are Open
2977	2	5	12	0	Smart TV turns Off
2978	61	21	6	0	(FitBit) I Fall Asleep
2979	2	5	12	0	Smart TV turns Off
2980	61	21	6	0	(FitBit) I Fall Asleep
2981	2	5	12	0	Smart TV turns Off
2982	61	21	6	0	(FitBit) I Fall Asleep
2983	14	14	5	0	Bedroom Window is Open
2984	20	18	7	0	It is Raining
2985	61	21	16	0	(FitBit) I Fall Asleep
2986	2	5	12	1	Smart TV is On
2987	63	12	6	0	Someone other than A Family Member Enters Home
2988	63	12	6	1	Alice is in Home
2989	63	12	6	2	Bobbie is in Home
2990	14	14	5	0	Bedroom Window is Open
2991	19	2	8	0	(Thermostat) The temperature is above 80 degrees
2992	2	5	12	0	Smart TV turns On
2993	61	21	16	1	(FitBit) I am Asleep
2994	52	11	14	2	"Smart TV turns On" last happened exactly 30m  ago
2995	58	24	5	0	Bathroom Window's curtains are Closed
2996	2	1	18	0	Roomba is On
2997	58	14	5	1	Bedroom Window's curtains are Closed
2998	58	25	5	0	Living Room Window's curtains are Closed
2999	14	14	5	0	Bedroom Window is Open
3000	19	2	8	0	(Thermostat) The temperature is below 60 degrees
3001	63	12	6	0	Someone other than A Family Member Enters Home
3002	63	12	6	1	Alice is in Home
3003	63	12	6	2	Bobbie is in Home
3004	58	25	5	0	Living Room Window's curtains Open
3005	58	24	5	0	Bathroom Window's curtains Open
3006	66	8	13	0	Smart Refrigerator's temperature becomes set below 40 degrees
3007	66	8	13	0	Smart Refrigerator's temperature becomes set below 40 degrees
3008	63	12	15	0	Someone other than A Family Member Enters Home
3009	2	1	18	1	Roomba is On
3010	58	24	5	0	Bathroom Window's curtains Open
3011	2	1	18	0	Roomba turns On
3012	58	25	5	0	Living Room Window's curtains are Open
3013	2	1	18	0	Roomba is On
3014	58	25	5	0	Living Room Window's curtains are Open
3015	2	1	18	0	Roomba turns On
3016	58	14	5	0	Bedroom Window's curtains are Open
3017	9	3	3	0	Amazon Echo is playing Pop
3018	18	18	6	0	(Weather Sensor) The weather stops being Raining
3019	19	18	6	1	(Weather Sensor) The temperature is above 60 degrees
3020	19	2	8	2	(Thermostat) The temperature is below 80 degrees
3022	64	22	17	0	Smart Faucet's water Turns On
3024	64	22	17	0	Smart Faucet's water Turns Off
3025	64	22	17	0	Smart Faucet's water Turns On
3026	63	12	6	0	Anyone Exits Kitchen
3027	52	11	14	0	It becomes true that "Smart Faucet's water Turns On" last happened exactly 15s  ago
3028	51	11	14	1	"Smart Faucet's water is running" was last in effect exactly  ago
3029	52	11	14	0	It becomes true that "Smart Faucet's water Turns On" last happened exactly 15s  ago
3030	51	11	14	1	"Smart Faucet's water is running" was last in effect exactly 1s  ago
3031	13	13	5	0	Front Door Lock is Locked
3032	55	17	9	0	It is Nighttime
3033	65	23	13	0	Smart Oven's temperature becomes 100 degrees
3034	63	12	15	1	Someone other than Alice is in Kitchen
3035	58	25	5	0	Living Room Window's curtains Open
3036	2	1	18	0	Roomba is On
3037	63	12	6	0	Someone other than A Family Member is in Home
3039	64	22	17	0	Smart Faucet's water is not running
3040	52	11	14	0	It becomes true that "Smart Refrigerator's door Opens" last happened exactly 2m  ago
3041	51	11	14	1	"Smart Refrigerator's door is Open" was last in effect exactly 1s  ago
3042	58	24	5	0	Bathroom Window's curtains Open
3044	2	5	12	0	Smart TV is On
3045	61	21	16	0	(FitBit) I am Asleep
3046	9	3	3	0	Amazon Echo starts playing Pop
3047	51	11	14	0	It becomes true that "(FitBit) I am Asleep" was last in effect exactly 30m  ago
3052	14	24	5	0	Bathroom Window is Open
3053	14	14	5	0	Bedroom Window is Closed
3054	14	25	5	0	Living Room Window is Closed
3055	13	23	13	0	Smart Oven is Locked
3056	60	23	13	0	Smart Oven's door is Closed
3060	19	8	13	0	(Smart Refrigerator) The temperature is 40 degrees
3061	14	14	5	0	Bedroom Window is Open
3062	20	18	7	0	It is Raining
3063	19	18	8	0	(Weather Sensor) The temperature is 60 degrees
3064	19	18	8	0	(Weather Sensor) The temperature is 80 degrees
3065	2	5	12	0	Smart TV turns Off
3066	25	17	9	0	(Clock) The time is after 23:00
3067	2	4	2	0	HUE Lights turns Off
3068	55	17	9	1	It is Nighttime
3069	60	8	13	0	Smart Refrigerator's door is Open
3070	2	1	18	0	Roomba is On
3071	25	17	9	0	(Clock) The time is after 17:00
3073	15	10	6	1	Security Camera detects motion
3074	63	12	6	2	Someone other than A Family Member is in Home
3075	63	12	6	3	Someone other than Alice is in Home
3076	63	12	6	4	Someone other than Bobbie is in Home
3077	60	8	13	0	Smart Refrigerator's door Opens
3078	52	11	14	1	"Smart Refrigerator's door Opens" last happened more than 2m  ago
3079	27	17	9	2	Clock's Alarm is not going off
3080	55	17	9	0	It is Nighttime
3081	2	5	1	0	Smart TV is Off
3082	25	17	9	0	(Clock) The time is 23:00
3084	25	17	9	0	(Clock) The time is 17:00
3085	64	22	17	0	Smart Faucet's water Turns On
3086	52	11	14	1	"Smart Faucet's water Turns On" last happened more than 15s  ago
3087	2	1	18	0	Roomba is Off
3088	25	17	9	0	(Clock) The time is 17:00
3092	9	3	3	0	Amazon Echo starts playing Pop
3094	63	12	6	1	Anyone is not in Home
3095	57	2	8	0	The AC is Off
3096	63	12	6	0	A Family Member is not in Home
3097	2	1	18	0	Roomba is Off
3098	25	17	9	0	(Clock) The time is 17:00
3099	64	22	17	0	Smart Faucet's water Turns Off
3100	64	22	17	0	Smart Faucet's water Turns On
3101	14	25	5	0	Living Room Window is Open
3102	13	23	13	0	Smart Oven is Locked
3103	63	12	6	0	Bobbie is in Kitchen
3104	63	12	15	0	Someone other than Alice Enters Home
3105	52	11	14	1	"Someone other than Anyone Enters Home" last happened more than 3h  ago
3106	58	24	5	0	Bathroom Window's curtains are Closed
3110	9	3	3	0	Amazon Echo stops playing Pop
3111	2	7	3	0	Speakers is On
3112	58	24	5	0	Bathroom Window's curtains Open
3113	55	17	9	0	It becomes Daytime
3114	13	14	4	1	Bedroom Window is Locked
3115	20	18	7	2	It is Not Raining
3116	63	12	15	0	Anyone Enters Bedroom
3118	9	3	3	0	Amazon Echo starts playing Pop
3119	55	17	9	0	It becomes Daytime
3120	63	12	6	1	Anyone is not in Home
3121	20	18	7	2	It is Not Raining
3122	63	12	6	0	A Family Member is not in Bedroom
3123	13	13	4	0	Front Door Lock is Locked
3124	9	3	3	0	Amazon Echo starts playing Pop
3125	19	2	8	0	(Thermostat) The temperature goes above 80 degrees
3126	14	24	5	0	Bathroom Window Closes
3127	55	17	9	1	It is Nighttime
3128	2	1	18	0	Roomba turns On
3129	58	24	5	1	Bathroom Window's curtains are Open
3130	58	14	5	2	Bedroom Window's curtains are Open
3131	58	25	5	3	Living Room Window's curtains are Open
3133	52	11	14	1	"Smart Faucet's water Turns On" last happened exactly 15s  ago
3134	2	5	12	0	Smart TV turns Off
3135	55	17	9	0	It becomes Nighttime
3138	13	13	4	0	Front Door Lock is Unlocked
3139	2	4	2	0	HUE Lights is Off
3140	55	17	9	0	It is Nighttime
3141	2	1	18	0	Roomba is On
3142	63	12	6	0	A Guest is in Home
3143	55	17	9	0	It becomes Daytime
3145	13	14	5	2	Bedroom Window is Unlocked
3146	14	14	5	3	Bedroom Window is Closed
3147	2	5	12	0	Smart TV turns Off
3148	61	21	6	0	(FitBit) I Fall Asleep
3149	13	13	5	0	Front Door Lock is Locked
3150	61	21	16	0	(FitBit) I am Asleep
3151	2	5	12	0	Smart TV is On
3152	61	21	6	0	(FitBit) I am Asleep
3153	57	2	8	0	The AC is Off
3154	19	2	8	0	(Thermostat) The temperature is above 79 degrees
3155	55	17	9	0	It becomes Daytime
3156	63	12	6	1	Anyone is not in Home
3157	13	14	5	2	Bedroom Window is Locked
3158	14	24	5	0	Bathroom Window Closes
3159	14	25	5	1	Living Room Window is Closed
3160	14	14	5	2	Bedroom Window is Closed
3161	66	8	13	0	Smart Refrigerator's temperature becomes set to something other than 40 degrees
3162	13	14	5	0	Bedroom Window Unlocks
3163	63	12	6	1	Anyone is not in Home
3164	13	13	5	0	Front Door Lock is Locked
3165	61	21	16	0	(FitBit) I am Asleep
3166	19	2	8	0	(Thermostat) The temperature becomes 80 degrees
3167	2	5	12	0	Smart TV turns Off
3168	61	21	6	0	(FitBit) I Fall Asleep
3169	14	14	5	0	Bedroom Window Closes
3170	14	24	5	1	Bathroom Window is Closed
3171	14	25	5	2	Living Room Window is Closed
3172	63	12	6	0	Anyone Enters Home
3173	55	17	9	1	It is Daytime
3174	13	14	5	2	Bedroom Window is Unlocked
3175	14	25	5	0	Living Room Window Closes
3176	14	24	5	1	Bathroom Window is Closed
3177	14	14	5	2	Bedroom Window is Closed
3179	19	2	8	0	(Thermostat) The temperature goes above 75 degrees
3180	63	12	6	1	Someone other than Nobody is in Home
3181	19	2	8	0	(Thermostat) The temperature goes above 75 degrees
3182	63	12	6	1	Someone other than Nobody is in Home
3183	19	2	8	0	(Thermostat) The temperature goes above 75 degrees
3184	63	12	6	1	Someone other than Nobody is in Home
3185	2	1	18	0	Roomba turns On
3186	58	25	5	1	Living Room Window's curtains are Open
3188	52	11	14	1	"Smart Faucet's water Turns On" last happened exactly 15m  ago
3190	19	2	8	0	(Thermostat) The temperature goes above 80 degrees
3193	15	10	6	0	Security Camera Starts Detecting Motion
3194	61	21	6	1	(FitBit) I am Asleep
3195	15	10	6	0	Security Camera Starts Detecting Motion
3196	61	21	6	1	(FitBit) I am Asleep
3198	57	2	8	0	The AC turns Off
3199	19	18	8	0	(Weather Sensor) The temperature is 80 degrees
3200	2	5	12	0	Smart TV turns On
3201	61	21	6	1	(FitBit) I am Awake
3202	62	21	16	2	(FitBit) My heart rate is below 75BPM
3203	2	1	18	0	Roomba turns On
3204	63	12	15	0	Anyone Enters Home
3205	2	1	18	0	Roomba is On
3206	63	12	6	0	A Guest is in Home
3207	9	3	3	0	Amazon Echo starts playing Pop
3208	57	2	8	0	The AC turns Off
3209	19	18	8	0	(Weather Sensor) The temperature is 80 degrees
3210	60	8	13	0	Smart Refrigerator's door Opens
3211	9	3	3	0	Amazon Echo starts playing Pop
3212	2	1	18	0	Roomba turns On
3214	58	24	5	0	Bathroom Window's curtains Open
3215	9	3	3	0	Amazon Echo is not playing Pop
3216	63	12	15	0	Anyone Enters Home
3217	52	11	14	0	It becomes true that "Smart Faucet's water Turns On" last happened more than 15s  ago
3218	64	22	17	1	Smart Faucet's water is running
3219	64	22	17	0	Smart Faucet's water Turns On
3220	50	11	14	1	"Smart Faucet's water Turns On" has occurred exactly 1 times in the last 15s 
3223	14	14	5	1	Bedroom Window is Open
3224	19	18	8	2	(Weather Sensor) The temperature is below 60 degrees
3225	63	12	6	0	Bobbie Enters Kitchen
3226	9	3	3	0	Amazon Echo starts playing Pop
3227	58	25	5	0	Living Room Window's curtains are Open
3228	2	1	18	0	Roomba is On
3229	63	12	15	0	Anyone Exits Home
3230	21	2	8	1	Thermostat is set above 75 degrees
3231	2	5	12	0	Smart TV turns Off
3232	61	21	16	0	(FitBit) I Fall Asleep
3233	63	12	15	0	Anyone Exits Home
3235	14	14	5	0	Bedroom Window is Open
3236	14	25	5	0	Living Room Window is Closed
3237	14	24	5	0	Bathroom Window is Closed
3239	2	23	13	1	Smart Oven is On
3240	64	22	17	0	Smart Faucet's water is running
3241	52	11	14	0	"Smart Faucet's water is running" last happened exactly 15s  ago
3243	61	21	16	0	(FitBit) I Fall Asleep
3244	58	25	5	0	Living Room Window's curtains Open
3245	2	1	18	1	Roomba is On
3246	60	23	13	0	Smart Oven's door Closes
3247	58	24	5	0	Bathroom Window's curtains Open
3248	19	8	13	0	(Smart Refrigerator) The temperature falls below 40 degrees
3249	14	25	5	0	Living Room Window is Open
3250	14	14	5	0	Bedroom Window is Closed
3251	14	24	5	0	Bathroom Window is Closed
3252	58	24	5	0	Bathroom Window's curtains Open
3253	63	12	15	0	Bobbie Enters Kitchen
3254	63	12	15	1	Nobody is in Kitchen
3255	60	23	13	2	Smart Oven's door is Closed
3256	63	12	6	0	Anyone is in Home
3257	21	2	8	0	Thermostat is set to 73 degrees
3258	63	12	6	0	A Guest Enters Home
3259	52	11	14	1	It becomes true that "A Guest Enters Home" last happened more than 3h  ago
3260	19	2	8	0	(Thermostat) The temperature goes above 80 degrees
3261	14	24	5	0	Bathroom Window is Open
3262	14	14	5	0	Bedroom Window is Closed
3263	14	25	5	0	Living Room Window is Closed
3264	63	12	15	0	Bobbie Enters Kitchen
3265	63	12	15	1	Nobody is in Kitchen
3266	60	23	13	2	Smart Oven's door is Open
3267	13	13	5	0	Front Door Lock is Locked
3268	61	21	6	0	(FitBit) I am Asleep
3269	13	13	5	0	Front Door Lock Unlocks
3270	61	21	6	0	(FitBit) I am Asleep
3272	13	13	5	0	Front Door Lock Unlocks
3274	13	13	5	1	Front Door Lock is Locked
3275	15	10	6	2	Security Camera detects motion
3277	60	23	13	1	Smart Oven's door is Open
3279	63	12	6	0	A Family Member Enters Bedroom
3280	14	14	5	0	Bedroom Window Closes
3281	14	25	5	1	Living Room Window is Closed
3282	9	3	3	0	Amazon Echo starts playing Pop
3283	35	3	3	1	pop is playing on Amazon Echo
3284	63	12	15	0	Anyone Enters Home
3285	2	5	12	0	Smart TV is On
3286	61	21	6	0	(FitBit) I am Asleep
3287	60	8	13	0	Smart Refrigerator's door is Open
3288	13	13	5	0	Front Door Lock Locks
3289	63	12	15	0	Someone other than Nobody is in Bedroom
3290	60	8	13	0	Smart Refrigerator's door is Open
3291	27	17	9	0	Clock's Alarm is going off
3292	19	8	13	0	(Smart Refrigerator) The temperature is below 40 degrees
3293	19	8	13	0	(Smart Refrigerator) The temperature is above 45 degrees
3295	63	12	6	0	Anyone is in Kitchen
3297	9	3	3	0	Amazon Echo is not playing Pop
3299	2	5	12	0	Smart TV turns Off
3300	61	21	16	0	(FitBit) I am Asleep
3301	52	11	14	0	It becomes true that "Smart Faucet's water Turns On" last happened exactly 15s  ago
3302	52	11	14	0	It becomes true that "Smart Oven's door Closes" last happened exactly 1s  ago
3303	63	12	15	1	Bobbie is in Kitchen
3304	66	8	13	0	Smart Refrigerator's temperature is set above 40 degrees
3305	2	1	18	0	Roomba turns Off
3306	55	17	9	0	It is Daytime
3307	2	5	1	0	Smart TV turns Off
3308	61	21	16	0	(FitBit) I Fall Asleep
3309	2	1	18	0	Roomba turns On
3310	2	1	18	1	Roomba is On
3311	14	14	5	0	Bedroom Window Opens
3312	20	18	7	1	It is Raining
3313	19	2	8	0	(Thermostat) The temperature goes above 80 degrees
3317	25	17	9	1	(Clock) The time is after 01:00
3318	57	2	8	0	The AC turns On
3319	19	2	8	0	(Thermostat) The temperature is above 79 degrees
3320	14	14	5	0	Bedroom Window Opens
3321	19	18	8	1	(Weather Sensor) The temperature is below 60 degrees
3322	60	8	13	0	Smart Refrigerator's door is Open
3323	14	14	5	0	Bedroom Window Closes
3324	14	24	5	1	Bathroom Window is Closed
3325	9	3	3	0	Amazon Echo is not playing Pop
3326	57	2	8	0	The AC turns Off
3327	19	2	8	0	(Thermostat) The temperature is below 70 degrees
3328	14	25	5	0	Living Room Window Closes
3329	14	24	5	1	Bathroom Window is Closed
3330	20	18	7	0	It starts raining
3331	14	14	5	1	Bedroom Window is Open
3332	14	25	5	0	Living Room Window Opens
3333	63	12	6	0	Anyone is in Home
3335	19	18	8	0	(Weather Sensor) The temperature goes above 60 degrees
3337	63	12	6	1	Anyone is not in Bathroom
3338	19	18	6	0	(Weather Sensor) The temperature goes above 80 degrees
3339	14	14	5	1	Bedroom Window is Open
3340	52	11	14	0	It becomes true that "Front Door Lock Locks" last happened exactly 9h  ago
3341	2	1	18	0	Roomba is On
3342	63	12	15	0	A Guest is in Home
3343	52	11	14	0	"A Guest is in Home" last happened less than 3h  ago
3344	14	14	5	0	Bedroom Window Closes
3345	14	25	5	1	Living Room Window is Closed
3347	19	18	6	0	(Weather Sensor) The temperature falls below 60 degrees
3348	14	14	5	1	Bedroom Window is Open
3349	25	17	9	0	(Clock) The time is 02:00
3350	2	5	12	0	Smart TV is On
3351	19	18	8	0	(Weather Sensor) The temperature goes above 80 degrees
3352	64	22	17	0	Smart Faucet's water Turns Off
3353	64	22	17	0	Smart Faucet's water Turns On
3354	57	2	8	0	The AC turns On
3355	63	12	15	1	Anyone is in Home
3357	2	1	18	0	Roomba is On
3358	2	23	13	0	Smart Oven is On
3359	63	12	6	1	Someone other than A Family Member is not in Home
3360	21	2	8	0	Thermostat's temperature becomes set to 75 degrees
3361	63	12	6	0	Nobody is in Home
3362	9	3	3	0	Amazon Echo starts playing Pop
3363	14	14	5	0	Bedroom Window Opens
3364	20	18	7	1	It is Raining
3366	14	14	5	0	Bedroom Window Opens
3367	19	18	8	1	(Weather Sensor) The temperature is above 80 degrees
3368	21	2	8	0	Thermostat's temperature becomes set to 72 degrees
3369	63	12	6	0	Anyone is in Home
3370	14	14	5	0	Bedroom Window is Open
3371	19	18	8	0	(Weather Sensor) The temperature is above 60 degrees
3372	19	18	8	0	(Weather Sensor) The temperature is below 80 degrees
3373	20	18	7	0	It is Not Raining
3374	58	24	5	0	Bathroom Window's curtains Close
3375	63	12	15	1	Anyone is in Home
3376	14	14	5	0	Bedroom Window Opens
3377	19	18	8	1	(Weather Sensor) The temperature is below 60 degrees
3378	13	14	4	0	Bedroom Window is Locked
3379	61	21	16	0	(FitBit) I am Asleep
3381	51	11	14	0	It becomes true that "Anyone is in Home" was last in effect exactly 1s  ago
3382	2	1	18	1	Roomba is On
3383	63	12	6	2	A Guest is in Home
3384	64	22	17	0	Smart Faucet's water Turns Off
3385	64	22	17	0	Smart Faucet's water Turns On
3386	58	24	5	0	Bathroom Window's curtains Open
3387	57	2	8	0	The AC is On
3388	63	12	15	0	Anyone is not in Home
3389	61	21	16	0	(FitBit) I Fall Asleep
3390	2	5	12	1	Smart TV is On
3391	52	11	14	2	"(FitBit) I Fall Asleep" last happened exactly 30m  ago
3392	60	8	13	0	Smart Refrigerator's door is Open
3393	58	24	5	0	Bathroom Window's curtains are Closed
3394	2	1	18	0	Roomba is On
3395	58	25	5	0	Living Room Window's curtains are Open
3396	9	3	3	0	Amazon Echo starts playing Pop
3397	64	22	17	0	Smart Faucet's water is running
3398	14	14	5	0	Bedroom Window is Open
3399	19	2	8	0	(Thermostat) The temperature is below 80 degrees
3400	19	2	8	0	(Thermostat) The temperature is above 60 degrees
3401	52	11	14	0	It becomes true that "Smart Refrigerator's door Opens" last happened more than 2m  ago
3402	60	8	13	1	Smart Refrigerator's door is Open
3403	58	24	5	0	Bathroom Window's curtains are Open
3404	52	11	14	0	It becomes true that "Smart Refrigerator's door Opens" last happened more than 2m  ago
3405	60	8	13	1	Smart Refrigerator's door is Open
3406	2	23	13	0	Smart Oven is On
3407	13	23	13	0	Smart Oven is Locked
3408	52	11	14	0	It becomes true that "Smart Refrigerator's door Opens" last happened more than 2m  ago
3409	60	8	13	1	Smart Refrigerator's door is Open
3410	15	10	6	0	Security Camera detects motion
3411	2	1	18	0	Roomba is On
3611	2	4	2	2	HUE Lights is Off
3412	63	12	15	0	Someone other than A Guest is not in Living Room
3413	2	5	12	0	Smart TV turns Off
3414	61	21	6	0	(FitBit) I Fall Asleep
3415	13	13	4	0	Front Door Lock is Unlocked
3416	63	12	15	0	Alice is in Home
3417	55	17	9	0	It is Nighttime
3418	9	3	3	0	Amazon Echo starts playing Pop
3419	66	8	13	0	Smart Refrigerator's temperature becomes set to 40 degrees
3420	58	24	5	0	Bathroom Window's curtains Open
3421	14	14	5	0	Bedroom Window is Open
3422	19	18	8	0	(Weather Sensor) The temperature is 61 degrees
3423	19	18	8	0	(Weather Sensor) The temperature is 79 degrees
3424	20	18	7	0	It is Not Raining
3425	58	25	5	0	Living Room Window's curtains Open
3426	2	1	18	1	Roomba is On
3427	50	11	14	0	It becomes true that "Roomba turns On" has occurred 1 times in the last 72h 
3429	2	1	18	1	Roomba is On
3430	58	14	5	0	Bedroom Window's curtains Open
3431	2	1	18	1	Roomba is On
3432	58	24	5	0	Bathroom Window's curtains Open
3433	2	1	18	1	Roomba is On
3434	58	25	5	0	Living Room Window's curtains are Closed
3435	2	1	18	0	Roomba is On
3436	2	1	18	0	Roomba is On
3437	63	12	6	0	A Guest is in Home
3438	52	11	14	0	"Roomba is On" last happened more than 3h 1s  ago
3439	2	1	18	0	Roomba turns Off
3440	58	25	5	1	Living Room Window's curtains are Closed
3441	63	12	6	0	Anyone is in Home
3442	19	2	8	0	(Thermostat) The temperature is 72 degrees
3443	2	1	18	0	Roomba is Off
3444	55	17	9	0	It is Nighttime
3445	19	2	8	0	(Thermostat) The temperature becomes 80 degrees
3446	21	2	8	1	Thermostat is set below 80 degrees
3449	58	14	5	1	Bedroom Window's curtains are Closed
3450	21	2	8	0	Thermostat's temperature becomes set above 80 degrees
3451	14	14	5	0	Bedroom Window is Open
3452	19	18	8	0	(Weather Sensor) The temperature is above 60 degrees
3453	19	18	8	0	(Weather Sensor) The temperature is not 80 degrees
3454	2	1	18	0	Roomba turns Off
3760	20	18	7	0	It is Raining
3455	63	12	15	0	Someone other than A Family Member is in Living Room
3456	2	1	18	0	Roomba turns Off
3457	58	24	5	1	Bathroom Window's curtains are Closed
3458	2	5	12	0	Smart TV is On
3459	61	21	16	0	(FitBit) I am Asleep
3462	19	2	8	0	(Thermostat) The temperature becomes 80 degrees
3463	19	2	8	0	(Thermostat) The temperature becomes 80 degrees
3464	21	2	8	1	Thermostat is set below 81 degrees
3465	57	2	8	2	The AC is Off
3466	14	14	5	0	Bedroom Window is Open
3467	20	18	7	0	It is Raining
3468	13	13	4	0	Front Door Lock is Locked
3469	55	17	9	0	It is Nighttime
3470	63	12	15	0	Anyone is in Home
3471	2	1	18	0	Roomba turns On
3472	58	25	5	0	Living Room Window's curtains are Open
3473	19	2	8	0	(Thermostat) The temperature goes above 80 degrees
3474	21	2	8	1	Thermostat is set above 80 degrees
3475	57	2	8	2	The AC is Off
3476	2	1	18	0	Roomba turns On
3477	58	14	5	0	Bedroom Window's curtains are Open
3478	14	14	5	0	Bedroom Window Closes
3479	19	2	8	0	(Thermostat) The temperature is above 80 degrees
3481	2	1	18	0	Roomba turns On
3482	58	24	5	0	Bathroom Window's curtains are Open
3483	14	14	5	0	Bedroom Window Closes
3484	19	2	8	0	(Thermostat) The temperature is below 60 degrees
3485	9	3	3	0	Amazon Echo stops playing Pop
3486	9	3	3	0	Amazon Echo is playing Pop
3487	25	17	9	0	(Clock) The time is after 23:00
3488	13	13	5	0	Front Door Lock is Locked
3489	2	5	12	0	Smart TV turns Off
3490	61	21	16	0	(FitBit) I Fall Asleep
3491	14	24	5	0	Bathroom Window Closes
3492	14	14	5	1	Bedroom Window is Closed
3493	14	25	5	2	Living Room Window is Closed
3495	2	5	12	0	Smart TV turns Off
3496	61	21	16	0	(FitBit) I Fall Asleep
3497	14	14	5	0	Bedroom Window Closes
3498	14	25	5	1	Living Room Window is Closed
3499	14	24	5	2	Bathroom Window is Closed
3501	64	22	17	0	Smart Faucet's water Turns Off
3502	64	22	17	0	Smart Faucet's water Turns On
3503	14	14	5	0	Bedroom Window Closes
3504	14	25	5	1	Living Room Window is Closed
3505	14	24	5	2	Bathroom Window is Closed
3506	64	22	17	0	Smart Faucet's water Turns Off
3507	64	22	17	0	Smart Faucet's water Turns On
3508	52	11	14	0	It becomes true that "(FitBit) I Fall Asleep" last happened more than 30m  ago
3509	2	5	12	1	Smart TV is On
3510	14	25	5	0	Living Room Window Closes
3511	14	24	5	1	Bathroom Window is Closed
3512	14	14	5	2	Bedroom Window is Closed
3513	14	14	5	0	Bedroom Window is Open
3514	19	18	8	0	(Weather Sensor) The temperature is above 79 degrees
3515	19	18	8	0	(Weather Sensor) The temperature is below 60 degrees
3516	20	18	7	0	It is Not Raining
3517	21	2	8	0	Thermostat is set above 80 degrees
3519	52	11	14	0	It becomes true that "(FitBit) I Fall Asleep" last happened more than 30m  ago
3520	2	5	12	1	Smart TV is On
3521	61	21	6	2	(FitBit) I am Asleep
3522	2	1	18	0	Roomba is On
3523	58	14	5	0	Bedroom Window's curtains are Open
3524	60	8	13	0	Smart Refrigerator's door Closes
3525	60	8	13	0	Smart Refrigerator's door Opens
3526	2	1	18	0	Roomba is On
3527	58	24	5	0	Bathroom Window's curtains are Open
3528	2	1	18	0	Roomba is On
3529	58	25	5	0	Living Room Window's curtains are Open
3530	2	1	18	0	Roomba turns On
3531	63	12	15	1	Someone other than Alice is in Home
3532	63	12	15	2	Someone other than Bobbie is in Home
3534	63	12	6	1	Anyone is not in Kitchen
3536	19	18	8	0	(Weather Sensor) The temperature is below 80 degrees
3537	19	18	8	0	(Weather Sensor) The temperature is above 60 degrees
3538	20	18	7	0	It is Not Raining
3539	55	17	9	0	It becomes Nighttime
3540	51	11	14	0	It becomes true that "Roomba is On" was last in effect exactly 1h  ago
3541	63	12	6	0	Anyone is in Home
3542	21	2	8	0	Thermostat is set above 70 degrees
3543	21	2	8	0	Thermostat is set below 75 degrees
3545	2	23	13	0	Smart Oven is On
3547	25	17	9	1	(Clock) The time is 16:00
3548	51	11	14	0	It becomes true that "Roomba is Off" was last in effect exactly 48h  ago
3549	58	24	5	0	Bathroom Window's curtains Open
3550	58	14	5	0	Bedroom Window's curtains Open
3551	58	25	5	0	Living Room Window's curtains Open
3552	58	25	5	0	Living Room Window's curtains Open
3553	2	1	18	1	Roomba is On
3555	2	1	18	1	Roomba is On
3556	19	2	8	0	(Thermostat) The temperature becomes 76 degrees
3557	19	8	13	0	(Smart Refrigerator) The temperature is above 40 degrees
3558	13	23	13	0	Smart Oven is Unlocked
3559	63	12	15	0	Bobbie is in Kitchen
3560	19	2	8	0	(Thermostat) The temperature goes above 75 degrees
3561	19	2	8	0	(Thermostat) The temperature goes above 75 degrees
3562	19	2	8	0	(Thermostat) The temperature goes above 80 degrees
3563	19	2	8	0	(Thermostat) The temperature becomes 80 degrees
3564	9	3	3	0	Amazon Echo starts playing Pop
3565	60	8	13	0	Smart Refrigerator's door is Open
3567	14	14	5	1	Bedroom Window is Open
3568	21	2	8	2	Thermostat is set to 70 degrees
3569	20	18	7	3	It is Raining
3570	51	11	14	0	It becomes true that "Smart Faucet's water is running" was last in effect exactly 15s  ago
3572	64	22	17	0	Smart Faucet's water is running
3573	63	12	6	0	Alice Exits Home
3574	63	12	6	1	Nobody is in Home
3575	64	22	17	0	Smart Faucet's water is running
3576	63	12	6	0	Bobbie Exits Home
3577	63	12	6	1	Nobody is in Home
3579	64	22	17	0	Smart Faucet's water is running
3580	13	23	13	0	Smart Oven Locks
3581	63	12	6	0	Bobbie is in Kitchen
3582	21	2	8	0	Thermostat's temperature becomes set above 70 degrees
3583	63	12	15	0	Anyone is in Home
3584	21	2	8	0	Thermostat's temperature becomes set below 75 degrees
3585	63	12	15	0	Anyone is in Home
3586	14	14	5	0	Bedroom Window Closes
3587	14	24	5	0	Bathroom Window Closes
3588	58	24	5	0	Bathroom Window's curtains are Closed
3589	14	25	5	0	Living Room Window Closes
3590	14	14	5	1	Bedroom Window is Closed
3591	14	24	5	2	Bathroom Window is Closed
3592	25	17	9	0	(Clock) The time becomes 08:00
3593	14	14	5	0	Bedroom Window Closes
3594	14	24	5	1	Bathroom Window is Closed
3595	14	25	5	2	Living Room Window is Closed
3596	14	24	5	0	Bathroom Window Closes
3597	14	14	5	1	Bedroom Window is Closed
3598	14	25	5	2	Living Room Window is Closed
3600	2	1	18	0	Roomba turns Off
3601	63	12	15	0	A Family Member is in Home
3603	21	2	8	0	Thermostat is set above 80 degrees
3604	14	24	5	0	Bathroom Window is Closed
3605	14	14	5	0	Bedroom Window is Closed
3606	14	25	5	0	Living Room Window is Closed
3607	35	3	3	0	Pop music starts playing on Amazon Echo
3609	55	17	9	0	It becomes Nighttime
3610	63	12	6	1	Anyone is in Bedroom
3612	15	10	6	3	Security Camera does not detect motion
3613	52	11	14	4	"Security Camera Stops Detecting Motion" last happened more than 30m  ago
3614	2	5	12	0	Smart TV is On
3615	61	21	16	0	(FitBit) I am Asleep
3616	19	8	13	0	(Smart Refrigerator) The temperature falls below 41 degrees
3617	64	22	17	0	Smart Faucet's water is running
3618	19	8	13	0	(Smart Refrigerator) The temperature becomes 46 degrees
3619	64	22	17	0	Smart Faucet's water Turns On
3620	19	8	13	0	(Smart Refrigerator) The temperature goes above 45 degrees
3621	64	22	17	0	Smart Faucet's water Turns On
3622	13	13	5	0	Front Door Lock Unlocks
3623	61	21	6	0	(FitBit) I am Asleep
3624	64	22	17	0	Smart Faucet's water Turns On
3625	9	3	3	0	Amazon Echo starts playing Pop
3626	14	25	5	0	Living Room Window is Open
3627	9	3	3	0	Amazon Echo is playing Pop
3628	52	11	14	0	It becomes true that "Someone other than A Family Member Enters Home" last happened exactly 3h  ago
3629	52	11	14	0	It becomes true that "Someone other than A Family Member Enters Home" last happened exactly 3h  ago
3633	19	2	8	0	(Thermostat) The temperature becomes 73 degrees
3634	63	12	6	0	Anyone is in Home
3635	19	2	8	0	(Thermostat) The temperature falls below 70 degrees
3636	63	12	6	1	Anyone is in Home
3637	19	8	13	0	(Smart Refrigerator) The temperature becomes 39 degrees
3638	19	2	8	0	(Thermostat) The temperature goes above 75 degrees
3639	63	12	6	1	Anyone is in Home
3641	14	14	5	0	Bedroom Window is Closed
3642	14	24	5	1	Bathroom Window is Closed
3643	61	21	16	0	(FitBit) I Fall Asleep
3644	2	5	12	1	Smart TV is On
3645	19	18	8	0	(Weather Sensor) The temperature becomes 80 degrees
3646	19	2	8	0	(Thermostat) The temperature is below 70 degrees
3647	63	12	6	0	Nobody is in Home
3648	57	2	8	0	The AC turns On
3649	19	2	8	0	(Thermostat) The temperature is above 80 degrees
3650	9	3	3	0	Amazon Echo starts playing Pop
3651	19	18	8	0	(Weather Sensor) The temperature falls below 60 degrees
3652	19	18	8	0	(Weather Sensor) The temperature goes above 80 degrees
3653	20	18	7	0	It starts raining
3654	19	2	8	0	(Thermostat) The temperature becomes 81 degrees
3655	66	8	13	0	Smart Refrigerator's temperature is set to 40 degrees
3656	20	18	7	0	It stops raining
3657	19	2	8	0	(Thermostat) The temperature becomes 81 degrees
3658	19	2	8	0	(Thermostat) The temperature becomes 80 degrees
3659	58	24	5	0	Bathroom Window's curtains Open
3660	2	1	1	1	Roomba is On
3662	63	12	6	0	Bobbie Enters Kitchen
3663	2	23	13	1	Smart Oven is On
3664	60	23	13	0	Smart Oven's door is Closed
3665	63	12	6	0	Bobbie is in Kitchen
3666	58	14	5	0	Bedroom Window's curtains Open
3667	2	1	1	1	Roomba is On
3668	19	8	13	0	(Smart Refrigerator) The temperature falls below 40 degrees
3669	13	23	13	0	Smart Oven is Locked
3670	63	12	6	0	Bobbie is in Kitchen
3671	58	25	5	0	Living Room Window's curtains Open
3672	2	1	1	1	Roomba is On
3673	9	3	3	0	Amazon Echo starts playing Pop
3674	9	3	3	0	Amazon Echo starts playing Pop
3675	61	21	6	0	(FitBit) I Fall Asleep
3676	2	5	1	1	Smart TV is On
3677	52	11	14	2	"(FitBit) I Fall Asleep" last happened exactly 31m  ago
3678	60	8	13	0	Smart Refrigerator's door Closes
3679	60	8	13	0	Smart Refrigerator's door Opens
3680	18	18	6	0	(Weather Sensor) The weather becomes Clear
3681	20	18	7	1	It is Not Raining
3682	19	18	8	0	(Weather Sensor) The temperature falls below 60 degrees
3683	58	25	5	0	Living Room Window's curtains Close
3684	55	17	9	1	It is Daytime
3685	19	2	8	0	(Thermostat) The temperature becomes 80 degrees
3686	19	18	8	0	(Weather Sensor) The temperature goes above 80 degrees
3687	2	1	1	0	Roomba turns On
3688	58	24	5	1	Bathroom Window's curtains are Open
3689	2	1	1	0	Roomba turns On
3690	58	14	5	1	Bedroom Window's curtains are Open
3691	2	1	18	0	Roomba is Off
3692	63	12	6	0	A Guest is in Home
3693	2	1	1	0	Roomba turns On
3694	58	25	5	1	Living Room Window's curtains are Open
3695	58	25	5	0	Living Room Window's curtains Open
3696	58	14	5	1	Bedroom Window's curtains are Open
3697	58	24	5	2	Bathroom Window's curtains are Open
3698	18	18	6	0	(Weather Sensor) The weather becomes Raining
3699	19	18	8	0	(Weather Sensor) The temperature goes above 80 degrees
3700	13	13	5	0	Front Door Lock is Unlocked
3701	61	21	16	0	(FitBit) I am Asleep
3702	64	22	13	0	Smart Faucet's water is running
3703	63	12	15	0	Bobbie Enters Kitchen
3704	2	23	13	1	Smart Oven is On
3706	2	1	1	0	Roomba turns On
3707	63	12	6	1	A Guest is in Home
3708	52	11	14	2	"A Guest Enters Home" last happened less than 3h  ago
3709	60	8	13	0	Smart Refrigerator's door Closes
3710	60	8	13	0	Smart Refrigerator's door Opens
3711	14	24	5	0	Bathroom Window Closes
3712	14	14	5	1	Bedroom Window is Closed
3713	14	14	5	0	Bedroom Window Closes
3714	14	25	5	1	Living Room Window is Closed
3715	19	8	13	0	(Smart Refrigerator) The temperature falls below 40 degrees
3716	14	25	5	0	Living Room Window Closes
3717	14	24	5	1	Bathroom Window is Closed
3718	63	12	6	0	Bobbie Enters Kitchen
3719	2	23	13	1	Smart Oven is On
3720	13	23	13	2	Smart Oven is Unlocked
3721	61	21	6	0	(FitBit) I Fall Asleep
3722	13	13	5	1	Front Door Lock is Unlocked
3723	52	11	14	0	It becomes true that "Smart Faucet's water Turns On" last happened exactly 15s  ago
3725	60	8	13	0	Smart Refrigerator's door Opens
3726	2	5	12	0	Smart TV is On
3727	61	21	16	0	(FitBit) I am Asleep
3728	52	11	14	0	It becomes true that "Smart Refrigerator's door Opens" last happened more than 2m  ago
3729	60	8	13	1	Smart Refrigerator's door is Open
3730	51	11	14	2	"Smart Refrigerator's door is Open" was last in effect more than 2m  ago
3731	52	11	14	0	It becomes true that "Smart Faucet's water Turns On" last happened exactly 15s  ago
3732	63	12	6	0	Someone other than Bobbie Enters Home
3733	2	1	18	1	Roomba is On
3734	51	11	14	0	It becomes true that "Smart Refrigerator's door is Closed" was last in effect exactly 2m  ago
3735	61	21	16	0	(FitBit) I Fall Asleep
3736	2	5	12	1	Smart TV is On
3737	51	11	14	0	It becomes true that "Smart Refrigerator's door is Open" was last in effect more than 2m  ago
3738	60	8	13	1	Smart Refrigerator's door is Open
3739	51	11	14	2	"Smart Refrigerator's door is Closed" was last in effect more than 2m  ago
3740	2	1	18	0	Roomba turns On
3741	2	1	18	0	Roomba turns On
3742	2	1	18	0	Roomba turns On
3743	55	17	9	0	It becomes Nighttime
3744	63	12	6	0	Someone other than A Family Member Enters Home
3745	13	13	4	1	Front Door Lock is Locked
3746	52	11	14	0	It becomes true that "Security Camera Stops Detecting Motion" last happened exactly 30m  ago
3747	49	11	14	0	It becomes true that "Bathroom Window is Closed" was active  ago
3748	14	14	5	1	Bedroom Window is Closed
3749	14	25	5	2	Living Room Window is Closed
3750	3	4	2	0	HUE Lights's brightness goes above 4
3751	19	18	8	0	(Weather Sensor) The temperature becomes 22 degrees
3752	58	25	5	0	Living Room Window's curtains Open
3753	14	14	5	0	Bedroom Window is Open
3754	19	18	8	0	(Weather Sensor) The temperature is above 80 degrees
3755	19	18	8	0	(Weather Sensor) The temperature is below 60 degrees
3756	20	18	7	0	It is Raining
3757	14	14	5	0	Bedroom Window is Open
3758	19	18	8	0	(Weather Sensor) The temperature is above 80 degrees
3759	19	18	8	0	(Weather Sensor) The temperature is below 60 degrees
3761	58	25	5	0	Living Room Window's curtains are Open
3762	2	1	18	0	Roomba is On
3764	2	1	18	0	Roomba turns On
3765	19	8	13	0	(Smart Refrigerator) The temperature is below 40 degrees
3766	49	11	14	0	It becomes true that "Smart Faucet's water is running" was active 15s  ago
3767	64	22	17	0	Smart Faucet's water Turns On
3769	64	22	13	0	Smart Faucet's water Turns Off
3872	2	5	12	1	Smart TV is On
3770	2	10	1	0	Security Camera turns On
3771	64	22	13	1	Smart Faucet's water is not running
3772	63	12	15	0	Someone other than A Family Member Enters Kitchen
3773	9	3	3	0	Amazon Echo starts playing Pop
3775	63	12	6	0	Bobbie is in Kitchen
3776	60	23	13	0	Smart Oven's door is Open
3777	19	18	8	0	(Weather Sensor) The temperature becomes 88 degrees
3778	19	18	8	0	(Weather Sensor) The temperature becomes 83 degrees
3779	14	25	5	0	Living Room Window is Closed
3780	18	18	7	0	(Weather Sensor) The weather is Clear
3782	20	18	7	0	It starts raining
3783	36	5	12	1	Smart TV is not tuned to Channel 758
3784	9	3	3	0	Amazon Echo starts playing Jazz
3785	37	5	12	0	animal planet stops playing on Smart TV
3787	2	5	12	1	Smart TV is On
3788	25	17	9	0	(Clock) The time becomes later than 00:00
3789	58	24	5	0	Bathroom Window's curtains are Open
3790	18	18	7	0	(Weather Sensor) The weather becomes Partly Cloudy
3791	20	18	7	0	It starts raining
3792	18	18	6	0	(Weather Sensor) The weather becomes Snowing
3793	35	3	3	0	pop music starts playing on Amazon Echo
3794	18	18	7	0	(Weather Sensor) The weather becomes Raining
3795	21	2	8	0	Thermostat's temperature becomes set to 75 degrees
3796	18	18	7	0	(Weather Sensor) The weather becomes Sunny
3797	21	2	8	0	Thermostat's temperature becomes set to 69 degrees
3798	63	12	6	0	Anyone Enters Bathroom
3799	9	3	3	0	Amazon Echo starts playing Pop
3800	9	3	3	1	Amazon Echo is playing Pop
3801	14	24	5	0	Bathroom Window Closes
3802	55	17	9	1	It is Daytime
3803	9	3	3	0	Amazon Echo starts playing Pop
3804	9	3	3	1	Amazon Echo is playing Pop
3805	2	1	18	0	Roomba turns On
3806	63	12	15	1	Nobody is not in Home
3807	58	24	5	2	Bathroom Window's curtains are Closed
3808	58	14	5	3	Bedroom Window's curtains are Closed
3809	58	25	5	4	Living Room Window's curtains are Closed
3810	64	22	17	0	Smart Faucet's water Turns On
3811	2	23	13	0	Smart Oven turns On
3812	60	23	13	1	Smart Oven's door is Closed
3813	63	12	6	2	Someone other than Bobbie is not in Home
3814	19	18	8	0	(Weather Sensor) The temperature goes above 80 degrees
3815	63	12	15	0	Anyone Enters Bedroom
3816	49	11	14	1	It becomes true that "(FitBit) I am Asleep" was active 30m  ago
3817	61	21	16	0	(FitBit) I Fall Asleep
3818	13	13	5	1	Front Door Lock is Unlocked
3819	63	12	15	0	Anyone Enters Home
3820	14	14	5	1	Bedroom Window is Closed
3821	14	25	5	2	Living Room Window is Closed
3822	14	24	5	3	Bathroom Window is Closed
3823	64	22	17	0	Smart Faucet's water Turns Off
3824	64	22	17	0	Smart Faucet's water Turns On
3825	13	23	13	0	Smart Oven Locks
3826	65	23	13	0	Smart Oven's temperature is above 200 degrees
3827	63	12	15	0	Anyone Enters Bedroom
3828	20	18	7	1	It is Not Raining
3829	19	2	8	2	(Thermostat) The temperature is below 80 degrees
3830	19	2	8	3	(Thermostat) The temperature is above 60 degrees
3831	63	12	15	0	Anyone Enters Bedroom
3832	20	18	7	1	It is Not Raining
3833	19	2	8	2	(Thermostat) The temperature is below 80 degrees
3834	19	2	8	3	(Thermostat) The temperature is above 60 degrees
3835	2	1	18	0	Roomba turns On
3836	58	25	5	1	Living Room Window's curtains are Open
3837	19	2	8	0	(Thermostat) The temperature goes above 80 degrees
3839	58	24	5	1	Bathroom Window's curtains are Open
3840	2	1	18	0	Roomba turns On
3841	58	14	5	1	Bedroom Window's curtains are Open
3842	14	25	5	0	Living Room Window is Open
3843	14	14	5	0	Bedroom Window is Open
3844	9	3	3	0	Amazon Echo starts playing Pop
3845	52	11	14	0	It becomes true that "Smart Faucet's water Turns On" last happened more than 15s  ago
3847	9	3	3	0	Amazon Echo starts playing Pop
3848	2	1	18	0	Roomba turns On
3849	25	17	9	0	(Clock) The time is after 18:00
3850	63	12	15	0	Bobbie Enters Kitchen
3851	14	14	5	0	Bedroom Window is Open
3852	19	18	8	0	(Weather Sensor) The temperature is below 80 degrees
3853	19	18	8	1	(Weather Sensor) The temperature is above 60 degrees
3854	20	18	7	2	It is Not Raining
3857	63	12	15	1	Anyone is not in Home
3858	19	2	8	0	(Thermostat) The temperature goes above 75 degrees
3859	63	12	15	1	Anyone is in Home
3860	19	2	8	0	(Thermostat) The temperature falls below 70 degrees
3861	63	12	15	1	Anyone is in Home
3862	19	2	8	0	(Thermostat) The temperature falls below 73 degrees
3863	19	2	8	0	(Thermostat) The temperature falls below 73 degrees
3864	63	12	15	1	Anyone is in Home
3865	57	2	8	0	The AC turns On
3866	63	12	15	1	Nobody is in Home
3867	21	2	8	0	Thermostat's temperature becomes set above 66 degrees
3868	63	12	15	1	Nobody is in Home
3869	19	18	8	0	(Weather Sensor) The temperature goes above 62 degrees
3870	63	12	15	1	Nobody is in Home
3871	52	11	14	0	It becomes true that "(FitBit) I Fall Asleep" last happened more than 30m  ago
3873	52	11	14	0	It becomes true that "Someone other than A Family Member Enters Home" last happened less than 3h  ago
3874	52	11	14	0	It becomes true that "Someone other than A Family Member Enters Home" last happened more than 3h  ago
3875	63	12	15	0	Bobbie Enters Kitchen
3876	2	23	13	1	Smart Oven is On
3877	58	24	5	0	Bathroom Window's curtains Open
3878	2	1	18	0	Roomba turns Off
3879	15	10	6	0	Security Camera Starts Detecting Motion
3880	19	2	8	0	(Thermostat) The temperature goes above 80 degrees
3881	2	5	12	0	Smart TV is On
3882	61	21	16	0	(FitBit) I am Asleep
3883	14	24	5	0	Bathroom Window Closes
3884	14	14	5	1	Bedroom Window is Closed
3885	14	25	5	2	Living Room Window is Closed
3886	14	14	5	0	Bedroom Window Closes
3887	14	24	5	1	Bathroom Window is Closed
3888	14	25	5	2	Living Room Window is Closed
3889	14	25	5	0	Living Room Window Closes
3890	14	24	5	1	Bathroom Window is Closed
3891	14	14	5	2	Bedroom Window is Closed
3892	13	13	5	0	Front Door Lock is Unlocked
3893	13	13	4	0	Front Door Lock is Locked
3894	61	21	16	0	(FitBit) I am Asleep
3895	61	21	16	0	(FitBit) I Fall Asleep
3896	13	13	5	0	Front Door Lock Unlocks
3897	61	21	16	1	(FitBit) I am Asleep
3898	14	14	5	0	Bedroom Window is Open
3899	19	2	8	0	(Thermostat) The temperature is above 60 degrees
3900	19	2	8	0	(Thermostat) The temperature is below 80 degrees
3901	20	18	7	0	It is Not Raining
3902	61	21	16	0	(FitBit) I Fall Asleep
3903	13	13	5	1	Front Door Lock is Unlocked
3904	21	2	8	0	Thermostat is set to 73 degrees
3905	63	12	15	0	Anyone is in Home
3906	58	14	5	0	Bedroom Window's curtains Close
3907	2	1	18	0	Roomba is On
3908	66	8	13	0	Smart Refrigerator's temperature becomes set below 40 degrees
3909	66	8	13	0	Smart Refrigerator's temperature becomes set below 40 degrees
3910	58	24	5	0	Bathroom Window's curtains Open
3911	2	1	18	0	Roomba turns On
3912	63	12	6	1	A Family Member is in Home
3913	63	12	6	2	A Guest is in Home
3914	9	3	3	0	Amazon Echo starts playing Pop
3915	60	8	13	0	Smart Refrigerator's door Opens
3916	60	8	13	1	Smart Refrigerator's door is Open
3917	60	8	13	2	Smart Refrigerator's door is Closed
3918	19	2	8	0	(Thermostat) The temperature becomes 80 degrees
3919	2	23	13	0	Smart Oven turns On
3921	13	14	4	1	Bedroom Window is Locked
3925	20	18	7	0	It starts raining
3928	13	23	13	0	Smart Oven Locks
3929	2	23	13	0	Smart Oven is On
3930	64	22	17	0	Smart Faucet's water is running
3931	14	14	5	0	Bedroom Window is Open
3932	19	18	8	0	(Weather Sensor) The temperature is below 80 degrees
3933	19	18	8	0	(Weather Sensor) The temperature is above 60 degrees
3934	20	18	7	0	It is Not Raining
3935	58	24	5	0	Bathroom Window's curtains are Open
3936	9	3	3	0	Amazon Echo starts playing Pop
3937	61	21	16	0	(FitBit) I am Asleep
3938	13	13	5	0	Front Door Lock is Unlocked
3939	66	8	13	0	Smart Refrigerator's temperature is set above 40 degrees
3940	66	8	13	0	Smart Refrigerator's temperature becomes set below 40 degrees
3941	21	2	8	0	Thermostat's temperature becomes set above 80 degrees
3942	21	2	8	0	Thermostat's temperature becomes set above 80 degrees
3943	21	2	8	0	Thermostat's temperature becomes set to 73 degrees
3944	63	12	6	0	Anyone is in Home
3945	21	2	8	0	Thermostat is set below 70 degrees
3946	63	12	6	0	Nobody is in Home
3947	21	2	8	0	Thermostat's temperature becomes set above 80 degrees
3948	66	8	13	0	Smart Refrigerator's temperature is set below 40 degrees
3949	66	8	13	0	Smart Refrigerator's temperature is set above 45 degrees
3950	66	8	13	0	Smart Refrigerator's temperature is set below 40 degrees
3951	21	2	8	0	Thermostat's temperature becomes set to 80 degrees
3952	63	12	6	0	Anyone is in Home
3953	21	2	8	0	Thermostat is set to 72 degrees
3954	21	2	8	0	Thermostat's temperature becomes set above 80 degrees
3955	66	8	13	0	Smart Refrigerator's temperature is set to 40 degrees
3956	21	2	8	0	Thermostat's temperature becomes set above 80 degrees
3957	9	3	3	0	Amazon Echo starts playing Pop
3958	9	3	3	0	Amazon Echo starts playing Pop
3959	14	25	5	0	Living Room Window is Open
3960	20	18	7	0	It is Raining
3961	14	25	5	0	Living Room Window Opens
3962	20	18	7	1	It is Raining
3963	20	18	7	0	It stops raining
3964	14	25	5	1	Living Room Window is Open
3965	14	25	5	0	Living Room Window is Open
3966	20	18	7	0	It is Raining
3967	14	25	5	0	Living Room Window Opens
3968	20	18	7	1	It is Raining
3969	2	4	2	2	HUE Lights is On
3970	20	18	7	0	It starts raining
3971	14	25	5	1	Living Room Window is Open
3972	14	25	5	0	Living Room Window is Open
3973	20	18	7	0	It is Raining
3974	14	25	5	0	Living Room Window Opens
3975	20	18	7	1	It is Not Raining
3976	20	18	7	0	It starts raining
3977	14	25	5	1	Living Room Window is Open
3978	14	25	5	0	Living Room Window is Open
3979	20	18	7	0	It is Raining
3980	14	25	5	0	Living Room Window Opens
3981	20	18	7	1	It is Raining
3982	20	18	7	0	It starts raining
3983	14	25	5	1	Living Room Window is Open
3984	14	25	5	0	Living Room Window is Open
3985	20	18	7	0	It is Raining
3986	20	18	7	0	It starts raining
3987	14	25	5	1	Living Room Window is Open
3988	14	24	5	0	Bathroom Window is Closed
3989	14	14	5	0	Bedroom Window is Closed
3990	14	25	5	0	Living Room Window is Closed
3991	14	25	5	0	Living Room Window Closes
3992	14	14	5	1	Bedroom Window is Closed
3993	14	24	5	2	Bathroom Window is Closed
3994	21	2	8	3	Thermostat is set below 80 degrees
3995	14	14	5	0	Bedroom Window Closes
3996	14	25	5	1	Living Room Window is Closed
3997	14	24	5	2	Bathroom Window is Closed
3998	14	24	5	0	Bathroom Window Closes
3999	14	14	5	1	Bedroom Window is Closed
4000	14	25	5	2	Living Room Window is Closed
4001	14	24	5	0	Bathroom Window is Closed
4002	14	14	5	0	Bedroom Window is Closed
4003	14	25	5	0	Living Room Window is Closed
4004	14	25	5	0	Living Room Window Closes
4005	14	14	5	1	Bedroom Window is Open
4006	14	14	5	0	Bedroom Window Closes
4007	14	25	5	1	Living Room Window is Closed
4008	14	24	5	2	Bathroom Window is Closed
4009	14	24	5	0	Bathroom Window Closes
4010	14	14	5	1	Bedroom Window is Closed
4011	14	25	5	2	Living Room Window is Closed
4012	14	24	5	0	Bathroom Window is Closed
4013	14	14	5	0	Bedroom Window is Closed
4014	14	25	5	0	Living Room Window is Closed
4015	14	25	5	0	Living Room Window Closes
4016	14	14	5	1	Bedroom Window is Closed
4017	14	24	5	2	Bathroom Window is Closed
4018	14	14	5	0	Bedroom Window Closes
4019	14	25	5	1	Living Room Window is Closed
4020	14	24	5	2	Bathroom Window is Closed
4021	14	24	5	0	Bathroom Window Closes
4022	14	14	5	1	Bedroom Window is Closed
4023	14	25	5	2	Living Room Window is Closed
4024	14	24	5	0	Bathroom Window is Closed
4025	14	14	5	0	Bedroom Window is Closed
4026	14	25	5	0	Living Room Window is Closed
4027	14	14	5	0	Bedroom Window Closes
4028	14	25	5	1	Living Room Window is Closed
4029	14	24	5	2	Bathroom Window is Closed
4030	14	24	5	0	Bathroom Window Closes
4031	14	14	5	1	Bedroom Window is Closed
4032	14	25	5	2	Living Room Window is Closed
4033	21	2	8	0	Thermostat is set above 80 degrees
4034	21	2	8	0	Thermostat's temperature becomes set above 85 degrees
4035	21	2	8	0	Thermostat is set above 80 degrees
4036	21	2	8	0	Thermostat's temperature becomes set above 80 degrees
4037	2	4	2	1	HUE Lights is On
4038	21	2	8	0	Thermostat is set above 80 degrees
4039	21	2	8	0	Thermostat's temperature becomes set above 80 degrees
4040	60	8	13	0	Smart Refrigerator's door is Open
4041	51	11	14	0	It becomes true that "Smart Refrigerator's door is Closed" was last in effect more than 120s  ago
4042	60	8	13	0	Smart Refrigerator's door is Open
4043	51	11	14	0	It becomes true that "Smart Refrigerator's door is Closed" was last in effect more than 60s  ago
4044	63	12	15	1	Alice is in Kitchen
4045	14	14	5	0	Bedroom Window is Open
4046	19	18	8	0	(Weather Sensor) The temperature is above 60 degrees
4047	19	18	8	0	(Weather Sensor) The temperature is below 80 degrees
4048	20	18	7	0	It is Not Raining
4049	19	18	8	0	(Weather Sensor) The temperature goes above 70 degrees
4050	19	18	8	1	(Weather Sensor) The temperature is below 80 degrees
4051	14	14	5	2	Bedroom Window is Closed
4052	20	18	7	3	It is Not Raining
4053	20	18	7	0	It stops raining
4054	19	18	8	1	(Weather Sensor) The temperature is above 60 degrees
4055	19	18	8	2	(Weather Sensor) The temperature is below 80 degrees
4056	14	14	5	3	Bedroom Window is Closed
4057	14	14	5	0	Bedroom Window Closes
4058	20	18	7	1	It is Not Raining
4059	19	18	8	2	(Weather Sensor) The temperature is above 60 degrees
4060	19	18	8	3	(Weather Sensor) The temperature is below 80 degrees
4061	14	14	5	0	Bedroom Window is Open
4062	19	18	8	0	(Weather Sensor) The temperature is above 60 degrees
4063	19	18	8	0	(Weather Sensor) The temperature is below 80 degrees
4064	20	18	7	0	It is Not Raining
4065	20	18	7	0	It stops raining
4066	19	18	8	1	(Weather Sensor) The temperature is above 60 degrees
4067	19	18	8	2	(Weather Sensor) The temperature is below 80 degrees
4068	14	14	5	3	Bedroom Window is Closed
4069	14	14	5	0	Bedroom Window Closes
4070	20	18	7	1	It is Not Raining
4071	19	18	8	2	(Weather Sensor) The temperature is above 60 degrees
4072	19	18	8	3	(Weather Sensor) The temperature is below 80 degrees
4073	21	2	8	0	Thermostat is set below 75 degrees
4074	63	12	15	0	A Family Member is in Home
4075	21	2	8	0	Thermostat is set above 70 degrees
4076	63	12	15	0	A Family Member is in Home
4077	21	2	8	0	Thermostat's temperature becomes set above 75 degrees
4078	63	12	15	1	A Family Member is in Home
4079	21	2	8	0	Thermostat's temperature becomes set above 75 degrees
4080	63	12	15	1	A Family Member is in Home
4081	21	2	8	0	Thermostat's temperature becomes set to 70 degrees
4082	63	12	15	1	A Family Member is in Home
4083	21	2	8	0	Thermostat's temperature becomes set to 75 degrees
4084	63	12	15	1	A Family Member is in Home
4085	21	2	8	0	Thermostat is set below 75 degrees
4086	63	12	15	0	A Family Member is in Home
4087	21	2	8	0	Thermostat is set above 70 degrees
4088	63	12	15	0	A Family Member is in Home
4089	21	2	8	0	Thermostat's temperature becomes set below 70 degrees
4090	63	12	15	1	A Family Member is in Home
4091	21	2	8	0	Thermostat's temperature becomes set above 75 degrees
4092	63	12	15	1	A Family Member is in Home
4093	21	2	8	0	Thermostat's temperature becomes set to 70 degrees
4094	63	12	15	1	A Family Member is in Home
4095	21	2	8	0	Thermostat's temperature becomes set to 75 degrees
4096	63	12	15	1	A Family Member is in Home
4097	63	12	15	0	A Family Member Enters Home
4098	21	2	8	1	Thermostat is set above 75 degrees
4099	63	12	15	0	A Family Member Enters Home
4100	21	2	8	1	Thermostat is set below 70 degrees
4101	63	12	15	0	A Family Member Enters Home
4102	21	2	8	1	Thermostat is set to 70 degrees
4103	58	24	5	0	Bathroom Window's curtains Open
4104	58	24	5	0	Bathroom Window's curtains Open
4105	2	4	2	1	HUE Lights is On
4106	58	24	5	0	Bathroom Window's curtains Open
4107	58	14	5	0	Bedroom Window's curtains Open
4108	58	24	5	0	Bathroom Window's curtains Open
4109	58	24	5	0	Bathroom Window's curtains Open
4110	13	13	5	0	Front Door Lock Unlocks
4111	61	21	16	0	(FitBit) I am Asleep
4112	13	13	5	0	Front Door Lock Unlocks
4113	2	4	2	1	HUE Lights is Off
4114	13	13	5	0	Front Door Lock Unlocks
4115	61	21	16	0	(FitBit) I am Asleep
4116	13	13	5	0	Front Door Lock Unlocks
4117	61	21	16	1	(FitBit) I am Asleep
4118	13	13	5	0	Front Door Lock Unlocks
4119	61	21	16	0	(FitBit) I am Asleep
4120	13	13	5	0	Front Door Lock Unlocks
4121	61	21	16	1	(FitBit) I am Asleep
4122	2	4	2	2	HUE Lights is On
4123	2	1	18	0	Roomba turns On
4124	63	12	15	0	A Guest Enters Home
4125	2	1	18	0	Roomba turns On
4126	52	11	14	1	"A Guest Enters Home" last happened less than 2h  ago
4127	2	5	12	0	Smart TV turns Off
4128	61	21	16	0	(FitBit) I Fall Asleep
4129	52	11	14	0	It becomes true that "(FitBit) I Fall Asleep" last happened more than 30m  ago
4130	2	5	12	1	Smart TV is On
4131	2	4	2	2	HUE Lights is On
4132	21	2	8	0	Thermostat is set above 70 degrees
4133	63	12	15	0	A Family Member is in Home
4134	21	2	8	0	Thermostat is set below 75 degrees
4135	63	12	15	0	A Family Member is in Home
4136	14	25	5	0	Living Room Window is Open
4137	19	18	8	0	(Weather Sensor) The temperature is above 60 degrees
4138	19	18	8	0	(Weather Sensor) The temperature is below 80 degrees
4139	20	18	7	0	It is Not Raining
4140	14	25	5	0	Living Room Window is Open
4141	20	18	7	0	It is Raining
4142	19	18	8	0	(Weather Sensor) The temperature is above 60 degrees
4143	14	25	5	0	Living Room Window is Open
4144	19	18	8	0	(Weather Sensor) The temperature is below 80 degrees
4145	14	25	5	0	Living Room Window is Open
4146	14	24	5	0	Bathroom Window is Closed
4147	14	14	5	0	Bedroom Window is Closed
4148	14	25	5	0	Living Room Window is Closed
4149	14	25	5	0	Living Room Window is Open
4150	19	18	8	0	(Weather Sensor) The temperature is above 60 degrees
4151	19	18	8	0	(Weather Sensor) The temperature is below 80 degrees
4152	20	18	7	0	It is Not Raining
4153	2	1	18	0	Roomba turns On
4154	63	12	15	0	A Guest Enters Home
4155	2	1	18	0	Roomba turns On
4156	58	25	5	0	Living Room Window's curtains are Open
4157	14	25	5	0	Living Room Window is Open
4158	14	25	5	0	Living Room Window is Closed
4159	57	2	8	0	The AC is On
4160	14	25	5	0	Living Room Window is Closed
4161	20	18	7	0	It is Raining
4162	14	25	5	0	Living Room Window is Open
4163	2	5	12	0	Smart TV turns Off
4164	61	21	16	0	(FitBit) I Fall Asleep
4165	2	5	12	0	Smart TV turns Off
4166	61	21	16	0	(FitBit) I Fall Asleep
\.


--
-- Name: backend_trigger_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backend_trigger_id_seq', 4166, true);


--
-- Data for Name: backend_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.backend_user (id, name, mode, code) FROM stdin;
1	jesse	rules	jesse
178	\N	rules	p1
208	\N	rules	p2
206	\N	rules	p3
193	\N	sp	p4
196	\N	sp	p5
171	\N	rules	p6
195	\N	sp	p7
201	\N	sp	p8
192	\N	sp	p9
199	\N	rules	p10
163	\N	sp	p11
174	\N	sp	p12
180	\N	rules	p13
186	\N	rules	p14
175	\N	sp	p15
215	\N	sp	p16
189	\N	sp	p17
216	\N	rules	p18
188	\N	rules	p19
159	\N	sp	p20
209	\N	rules	p21
207	\N	rules	p22
204	\N	rules	p23
200	\N	sp	p24
158	\N	rules	p25
217	\N	sp	p26
210	\N	rules	p27
176	\N	rules	p28
179	\N	rules	p29
156	\N	rules	p30
205	\N	sp	p31
202	\N	sp	p32
165	\N	rules	p33
214	\N	rules	p34
187	\N	sp	p35
166	\N	sp	p36
164	\N	rules	p37
218	\N	rules	p38
162	\N	sp	p39
167	\N	rules	p40
184	\N	sp	p41
211	\N	sp	p42
194	\N	sp	p43
185	\N	rules	p44
173	\N	sp	p45
182	\N	sp	p46
197	\N	sp	p47
160	\N	sp	p48
168	\N	sp	p49
213	\N	rules	p50
170	\N	sp	p51
220	\N	rules	p5
221	\N	sp	mutate
222	\N	rules	mutate
223	\N	rules	p51
224	\N	rules	p49
225	\N	rules	p48
226	\N	rules	p47
227	\N	rules	p46
228	\N	rules	p45
229	\N	rules	p41
230	\N	rules	p39
231	\N	rules	p36
232	\N	rules	p26
233	\N	rules	p20
234	\N	rules	p35
235	\N	rules	p4
236	\N	rules	p7
237	\N	rules	p8
238	\N	sp	multiple
239	\N	rules	multiple
\.


--
-- Name: backend_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.backend_user_id_seq', 239, true);


--
-- Name: backend_binparam_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_binparam
    ADD CONSTRAINT backend_binparam_pkey PRIMARY KEY (parameter_ptr_id);


--
-- Name: backend_capability_chann_capability_id_channel_id_131031e1_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_capability_channels
    ADD CONSTRAINT backend_capability_chann_capability_id_channel_id_131031e1_uniq UNIQUE (capability_id, channel_id);


--
-- Name: backend_capability_channels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_capability_channels
    ADD CONSTRAINT backend_capability_channels_pkey PRIMARY KEY (id);


--
-- Name: backend_capability_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_capability
    ADD CONSTRAINT backend_capability_pkey PRIMARY KEY (id);


--
-- Name: backend_channel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_channel
    ADD CONSTRAINT backend_channel_pkey PRIMARY KEY (id);


--
-- Name: backend_colorparam_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_colorparam
    ADD CONSTRAINT backend_colorparam_pkey PRIMARY KEY (parameter_ptr_id);


--
-- Name: backend_condition_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_condition
    ADD CONSTRAINT backend_condition_pkey PRIMARY KEY (id);


--
-- Name: backend_device_capabilit_device_id_capability_id_690d9551_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_device_caps
    ADD CONSTRAINT backend_device_capabilit_device_id_capability_id_690d9551_uniq UNIQUE (device_id, capability_id);


--
-- Name: backend_device_capabilities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_device_caps
    ADD CONSTRAINT backend_device_capabilities_pkey PRIMARY KEY (id);


--
-- Name: backend_device_chans_device_id_channel_id_d581e087_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_device_chans
    ADD CONSTRAINT backend_device_chans_device_id_channel_id_d581e087_uniq UNIQUE (device_id, channel_id);


--
-- Name: backend_device_chans_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_device_chans
    ADD CONSTRAINT backend_device_chans_pkey PRIMARY KEY (id);


--
-- Name: backend_device_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_device
    ADD CONSTRAINT backend_device_pkey PRIMARY KEY (id);


--
-- Name: backend_durationparam_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_durationparam
    ADD CONSTRAINT backend_durationparam_pkey PRIMARY KEY (parameter_ptr_id);


--
-- Name: backend_esrule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_esrule
    ADD CONSTRAINT backend_esrule_pkey PRIMARY KEY (rule_ptr_id);


--
-- Name: backend_esrule_triggersS_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."backend_esrule_Striggers"
    ADD CONSTRAINT "backend_esrule_triggersS_pkey" PRIMARY KEY (id);


--
-- Name: backend_esrule_triggerss_esrule_id_state_id_e2f7e575_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."backend_esrule_Striggers"
    ADD CONSTRAINT backend_esrule_triggerss_esrule_id_state_id_e2f7e575_uniq UNIQUE (esrule_id, trigger_id);


--
-- Name: backend_inputparam_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_inputparam
    ADD CONSTRAINT backend_inputparam_pkey PRIMARY KEY (parameter_ptr_id);


--
-- Name: backend_metaparam_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_metaparam
    ADD CONSTRAINT backend_metaparam_pkey PRIMARY KEY (parameter_ptr_id);


--
-- Name: backend_parameter_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_parameter
    ADD CONSTRAINT backend_parameter_pkey PRIMARY KEY (id);


--
-- Name: backend_parval_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_parval
    ADD CONSTRAINT backend_parval_pkey PRIMARY KEY (id);


--
-- Name: backend_rangeparam_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_rangeparam
    ADD CONSTRAINT backend_rangeparam_pkey PRIMARY KEY (parameter_ptr_id);


--
-- Name: backend_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_rule
    ADD CONSTRAINT backend_rule_pkey PRIMARY KEY (id);


--
-- Name: backend_safetyprop_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_safetyprop
    ADD CONSTRAINT backend_safetyprop_pkey PRIMARY KEY (id);


--
-- Name: backend_setparam_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_setparam
    ADD CONSTRAINT backend_setparam_pkey PRIMARY KEY (parameter_ptr_id);


--
-- Name: backend_setparamopt_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_setparamopt
    ADD CONSTRAINT backend_setparamopt_pkey PRIMARY KEY (id);


--
-- Name: backend_sp1_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_sp1
    ADD CONSTRAINT backend_sp1_pkey PRIMARY KEY (safetyprop_ptr_id);


--
-- Name: backend_sp1_triggers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_sp1_triggers
    ADD CONSTRAINT backend_sp1_triggers_pkey PRIMARY KEY (id);


--
-- Name: backend_sp1_triggers_sp1_id_trigger_id_8b45f99b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_sp1_triggers
    ADD CONSTRAINT backend_sp1_triggers_sp1_id_trigger_id_8b45f99b_uniq UNIQUE (sp1_id, trigger_id);


--
-- Name: backend_sp2_conds_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_sp2_conds
    ADD CONSTRAINT backend_sp2_conds_pkey PRIMARY KEY (id);


--
-- Name: backend_sp2_conds_sp2_id_trigger_id_8df7a647_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_sp2_conds
    ADD CONSTRAINT backend_sp2_conds_sp2_id_trigger_id_8df7a647_uniq UNIQUE (sp2_id, trigger_id);


--
-- Name: backend_sp2_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_sp2
    ADD CONSTRAINT backend_sp2_pkey PRIMARY KEY (safetyprop_ptr_id);


--
-- Name: backend_sp3_conds_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_sp3_conds
    ADD CONSTRAINT backend_sp3_conds_pkey PRIMARY KEY (id);


--
-- Name: backend_sp3_conds_sp3_id_trigger_id_472a7be0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_sp3_conds
    ADD CONSTRAINT backend_sp3_conds_sp3_id_trigger_id_472a7be0_uniq UNIQUE (sp3_id, trigger_id);


--
-- Name: backend_sp3_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_sp3
    ADD CONSTRAINT backend_sp3_pkey PRIMARY KEY (safetyprop_ptr_id);


--
-- Name: backend_ssrule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_ssrule
    ADD CONSTRAINT backend_ssrule_pkey PRIMARY KEY (rule_ptr_id);


--
-- Name: backend_ssrule_triggers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_ssrule_triggers
    ADD CONSTRAINT backend_ssrule_triggers_pkey PRIMARY KEY (id);


--
-- Name: backend_ssrule_triggers_ssrule_id_state_id_9e03b8bc_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_ssrule_triggers
    ADD CONSTRAINT backend_ssrule_triggers_ssrule_id_state_id_9e03b8bc_uniq UNIQUE (ssrule_id, trigger_id);


--
-- Name: backend_state_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_state
    ADD CONSTRAINT backend_state_pkey PRIMARY KEY (id);


--
-- Name: backend_statelog_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_statelog
    ADD CONSTRAINT backend_statelog_pkey PRIMARY KEY (id);


--
-- Name: backend_timeparam_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_timeparam
    ADD CONSTRAINT backend_timeparam_pkey PRIMARY KEY (parameter_ptr_id);


--
-- Name: backend_trigger_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_trigger
    ADD CONSTRAINT backend_trigger_pkey PRIMARY KEY (id);


--
-- Name: backend_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_user
    ADD CONSTRAINT backend_user_pkey PRIMARY KEY (id);


--
-- Name: backend_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_user
    ADD CONSTRAINT backend_user_username_key UNIQUE (name);


--
-- Name: backend_capability_channels_capability_id_1bccd6c0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backend_capability_channels_capability_id_1bccd6c0 ON public.backend_capability_channels USING btree (capability_id);


--
-- Name: backend_capability_channels_channel_id_84c47a3a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backend_capability_channels_channel_id_84c47a3a ON public.backend_capability_channels USING btree (channel_id);


--
-- Name: backend_condition_par_id_bddbc67e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backend_condition_par_id_bddbc67e ON public.backend_condition USING btree (par_id);


--
-- Name: backend_condition_trigger_id_5a7be7ee; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backend_condition_trigger_id_5a7be7ee ON public.backend_condition USING btree (trigger_id);


--
-- Name: backend_device_capabilities_capability_id_b710e85c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backend_device_capabilities_capability_id_b710e85c ON public.backend_device_caps USING btree (capability_id);


--
-- Name: backend_device_capabilities_device_id_d1ec2214; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backend_device_capabilities_device_id_d1ec2214 ON public.backend_device_caps USING btree (device_id);


--
-- Name: backend_device_chans_channel_id_d5e05cbd; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backend_device_chans_channel_id_d5e05cbd ON public.backend_device_chans USING btree (channel_id);


--
-- Name: backend_device_chans_device_id_7eaeaa06; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backend_device_chans_device_id_7eaeaa06 ON public.backend_device_chans USING btree (device_id);


--
-- Name: backend_device_owner_id_a248fd8b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backend_device_owner_id_a248fd8b ON public.backend_device USING btree (owner_id);


--
-- Name: backend_esrule_actionstate_id_e2e66cac; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backend_esrule_actionstate_id_e2e66cac ON public.backend_esrule USING btree (action_id);


--
-- Name: backend_esrule_triggerE_id_91b6be8d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "backend_esrule_triggerE_id_91b6be8d" ON public.backend_esrule USING btree ("Etrigger_id");


--
-- Name: backend_esrule_triggersS_esrule_id_7ea33e3d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "backend_esrule_triggersS_esrule_id_7ea33e3d" ON public."backend_esrule_Striggers" USING btree (esrule_id);


--
-- Name: backend_esrule_triggersS_state_id_22f7e9e4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "backend_esrule_triggersS_state_id_22f7e9e4" ON public."backend_esrule_Striggers" USING btree (trigger_id);


--
-- Name: backend_parameter_cap_id_b4de2acb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backend_parameter_cap_id_b4de2acb ON public.backend_parameter USING btree (cap_id);


--
-- Name: backend_parval_par_id_049e0be4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backend_parval_par_id_049e0be4 ON public.backend_parval USING btree (par_id);


--
-- Name: backend_parval_state_id_cde26674; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backend_parval_state_id_cde26674 ON public.backend_parval USING btree (state_id);


--
-- Name: backend_rule_owner_id_32585cc6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backend_rule_owner_id_32585cc6 ON public.backend_rule USING btree (owner_id);


--
-- Name: backend_safetyprop_owner_id_0b165fad; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backend_safetyprop_owner_id_0b165fad ON public.backend_safetyprop USING btree (owner_id);


--
-- Name: backend_setparamopt_param_id_07e0f502; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backend_setparamopt_param_id_07e0f502 ON public.backend_setparamopt USING btree (param_id);


--
-- Name: backend_sp1_triggers_sp1_id_c4c1aca5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backend_sp1_triggers_sp1_id_c4c1aca5 ON public.backend_sp1_triggers USING btree (sp1_id);


--
-- Name: backend_sp1_triggers_trigger_id_83a751db; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backend_sp1_triggers_trigger_id_83a751db ON public.backend_sp1_triggers USING btree (trigger_id);


--
-- Name: backend_sp2_conds_sp2_id_1fb0191a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backend_sp2_conds_sp2_id_1fb0191a ON public.backend_sp2_conds USING btree (sp2_id);


--
-- Name: backend_sp2_conds_trigger_id_b90c6fa9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backend_sp2_conds_trigger_id_b90c6fa9 ON public.backend_sp2_conds USING btree (trigger_id);


--
-- Name: backend_sp2_state_id_01caf21d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backend_sp2_state_id_01caf21d ON public.backend_sp2 USING btree (state_id);


--
-- Name: backend_sp3_conds_sp3_id_f2c1fec5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backend_sp3_conds_sp3_id_f2c1fec5 ON public.backend_sp3_conds USING btree (sp3_id);


--
-- Name: backend_sp3_conds_trigger_id_4aa9489f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backend_sp3_conds_trigger_id_4aa9489f ON public.backend_sp3_conds USING btree (trigger_id);


--
-- Name: backend_sp3_event_id_b133fd92; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backend_sp3_event_id_b133fd92 ON public.backend_sp3 USING btree (event_id);


--
-- Name: backend_ssrule_actionstate_id_c9461e31; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backend_ssrule_actionstate_id_c9461e31 ON public.backend_ssrule USING btree (action_id);


--
-- Name: backend_ssrule_triggers_ssrule_id_c5913b93; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backend_ssrule_triggers_ssrule_id_c5913b93 ON public.backend_ssrule_triggers USING btree (ssrule_id);


--
-- Name: backend_ssrule_triggers_state_id_c7f0416f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backend_ssrule_triggers_state_id_c7f0416f ON public.backend_ssrule_triggers USING btree (trigger_id);


--
-- Name: backend_state_cap_id_25727ebe; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backend_state_cap_id_25727ebe ON public.backend_state USING btree (cap_id);


--
-- Name: backend_state_chan_id_b9d0a0d4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backend_state_chan_id_b9d0a0d4 ON public.backend_state USING btree (chan_id);


--
-- Name: backend_state_dev_id_a376fae0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backend_state_dev_id_a376fae0 ON public.backend_state USING btree (dev_id);


--
-- Name: backend_statelog_cap_id_a554767b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backend_statelog_cap_id_a554767b ON public.backend_statelog USING btree (cap_id);


--
-- Name: backend_statelog_dev_id_63f7e345; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backend_statelog_dev_id_63f7e345 ON public.backend_statelog USING btree (dev_id);


--
-- Name: backend_statelog_param_id_ab9f8aa5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backend_statelog_param_id_ab9f8aa5 ON public.backend_statelog USING btree (param_id);


--
-- Name: backend_trigger_cap2_id_b0a35770; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backend_trigger_cap2_id_b0a35770 ON public.backend_trigger USING btree (cap_id);


--
-- Name: backend_trigger_chan_id_bbc8de39; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backend_trigger_chan_id_bbc8de39 ON public.backend_trigger USING btree (chan_id);


--
-- Name: backend_trigger_dev2_id_f21c5876; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backend_trigger_dev2_id_f21c5876 ON public.backend_trigger USING btree (dev_id);


--
-- Name: backend_user_username_eb55703b_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX backend_user_username_eb55703b_like ON public.backend_user USING btree (name varchar_pattern_ops);


--
-- Name: backend_binparam_parameter_ptr_id_4fc53892_fk_backend_p; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_binparam
    ADD CONSTRAINT backend_binparam_parameter_ptr_id_4fc53892_fk_backend_p FOREIGN KEY (parameter_ptr_id) REFERENCES public.backend_parameter(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_capability_c_capability_id_1bccd6c0_fk_backend_c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_capability_channels
    ADD CONSTRAINT backend_capability_c_capability_id_1bccd6c0_fk_backend_c FOREIGN KEY (capability_id) REFERENCES public.backend_capability(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_capability_c_channel_id_84c47a3a_fk_backend_c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_capability_channels
    ADD CONSTRAINT backend_capability_c_channel_id_84c47a3a_fk_backend_c FOREIGN KEY (channel_id) REFERENCES public.backend_channel(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_colorparam_parameter_ptr_id_2a10b1b1_fk_backend_p; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_colorparam
    ADD CONSTRAINT backend_colorparam_parameter_ptr_id_2a10b1b1_fk_backend_p FOREIGN KEY (parameter_ptr_id) REFERENCES public.backend_parameter(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_condition_par_id_bddbc67e_fk_backend_parameter_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_condition
    ADD CONSTRAINT backend_condition_par_id_bddbc67e_fk_backend_parameter_id FOREIGN KEY (par_id) REFERENCES public.backend_parameter(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_condition_trigger_id_5a7be7ee_fk_backend_trigger_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_condition
    ADD CONSTRAINT backend_condition_trigger_id_5a7be7ee_fk_backend_trigger_id FOREIGN KEY (trigger_id) REFERENCES public.backend_trigger(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_device_caps_capability_id_6d681664_fk_backend_c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_device_caps
    ADD CONSTRAINT backend_device_caps_capability_id_6d681664_fk_backend_c FOREIGN KEY (capability_id) REFERENCES public.backend_capability(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_device_caps_device_id_582e64dc_fk_backend_device_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_device_caps
    ADD CONSTRAINT backend_device_caps_device_id_582e64dc_fk_backend_device_id FOREIGN KEY (device_id) REFERENCES public.backend_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_device_chans_channel_id_d5e05cbd_fk_backend_channel_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_device_chans
    ADD CONSTRAINT backend_device_chans_channel_id_d5e05cbd_fk_backend_channel_id FOREIGN KEY (channel_id) REFERENCES public.backend_channel(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_device_chans_device_id_7eaeaa06_fk_backend_device_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_device_chans
    ADD CONSTRAINT backend_device_chans_device_id_7eaeaa06_fk_backend_device_id FOREIGN KEY (device_id) REFERENCES public.backend_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_device_owner_id_a248fd8b_fk_backend_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_device
    ADD CONSTRAINT backend_device_owner_id_a248fd8b_fk_backend_user_id FOREIGN KEY (owner_id) REFERENCES public.backend_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_durationpara_parameter_ptr_id_06b460c1_fk_backend_p; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_durationparam
    ADD CONSTRAINT backend_durationpara_parameter_ptr_id_06b460c1_fk_backend_p FOREIGN KEY (parameter_ptr_id) REFERENCES public.backend_parameter(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_esrule_action_id_722dc031_fk_backend_state_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_esrule
    ADD CONSTRAINT backend_esrule_action_id_722dc031_fk_backend_state_id FOREIGN KEY (action_id) REFERENCES public.backend_state(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_esrule_rule_ptr_id_f8f656ef_fk_backend_rule_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_esrule
    ADD CONSTRAINT backend_esrule_rule_ptr_id_f8f656ef_fk_backend_rule_id FOREIGN KEY (rule_ptr_id) REFERENCES public.backend_rule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_inputparam_parameter_ptr_id_7d2d6fe8_fk_backend_p; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_inputparam
    ADD CONSTRAINT backend_inputparam_parameter_ptr_id_7d2d6fe8_fk_backend_p FOREIGN KEY (parameter_ptr_id) REFERENCES public.backend_parameter(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_metaparam_parameter_ptr_id_56ce872d_fk_backend_p; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_metaparam
    ADD CONSTRAINT backend_metaparam_parameter_ptr_id_56ce872d_fk_backend_p FOREIGN KEY (parameter_ptr_id) REFERENCES public.backend_parameter(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_parameter_cap_id_b4de2acb_fk_backend_capability_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_parameter
    ADD CONSTRAINT backend_parameter_cap_id_b4de2acb_fk_backend_capability_id FOREIGN KEY (cap_id) REFERENCES public.backend_capability(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_parval_par_id_049e0be4_fk_backend_parameter_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_parval
    ADD CONSTRAINT backend_parval_par_id_049e0be4_fk_backend_parameter_id FOREIGN KEY (par_id) REFERENCES public.backend_parameter(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_parval_state_id_cde26674_fk_backend_state_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_parval
    ADD CONSTRAINT backend_parval_state_id_cde26674_fk_backend_state_id FOREIGN KEY (state_id) REFERENCES public.backend_state(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_rangeparam_parameter_ptr_id_9a607db7_fk_backend_p; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_rangeparam
    ADD CONSTRAINT backend_rangeparam_parameter_ptr_id_9a607db7_fk_backend_p FOREIGN KEY (parameter_ptr_id) REFERENCES public.backend_parameter(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_rule_owner_id_32585cc6_fk_backend_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_rule
    ADD CONSTRAINT backend_rule_owner_id_32585cc6_fk_backend_user_id FOREIGN KEY (owner_id) REFERENCES public.backend_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_safetyprop_owner_id_0b165fad_fk_backend_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_safetyprop
    ADD CONSTRAINT backend_safetyprop_owner_id_0b165fad_fk_backend_user_id FOREIGN KEY (owner_id) REFERENCES public.backend_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_setparam_parameter_ptr_id_18bfc60c_fk_backend_p; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_setparam
    ADD CONSTRAINT backend_setparam_parameter_ptr_id_18bfc60c_fk_backend_p FOREIGN KEY (parameter_ptr_id) REFERENCES public.backend_parameter(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_setparamopt_param_id_07e0f502_fk_backend_s; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_setparamopt
    ADD CONSTRAINT backend_setparamopt_param_id_07e0f502_fk_backend_s FOREIGN KEY (param_id) REFERENCES public.backend_setparam(parameter_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_sp1_safetyprop_ptr_id_d29a5f23_fk_backend_safetyprop_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_sp1
    ADD CONSTRAINT backend_sp1_safetyprop_ptr_id_d29a5f23_fk_backend_safetyprop_id FOREIGN KEY (safetyprop_ptr_id) REFERENCES public.backend_safetyprop(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_sp1_triggers_sp1_id_c4c1aca5_fk_backend_s; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_sp1_triggers
    ADD CONSTRAINT backend_sp1_triggers_sp1_id_c4c1aca5_fk_backend_s FOREIGN KEY (sp1_id) REFERENCES public.backend_sp1(safetyprop_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_sp1_triggers_trigger_id_83a751db_fk_backend_trigger_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_sp1_triggers
    ADD CONSTRAINT backend_sp1_triggers_trigger_id_83a751db_fk_backend_trigger_id FOREIGN KEY (trigger_id) REFERENCES public.backend_trigger(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_sp2_conds_sp2_id_1fb0191a_fk_backend_s; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_sp2_conds
    ADD CONSTRAINT backend_sp2_conds_sp2_id_1fb0191a_fk_backend_s FOREIGN KEY (sp2_id) REFERENCES public.backend_sp2(safetyprop_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_sp2_conds_trigger_id_b90c6fa9_fk_backend_trigger_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_sp2_conds
    ADD CONSTRAINT backend_sp2_conds_trigger_id_b90c6fa9_fk_backend_trigger_id FOREIGN KEY (trigger_id) REFERENCES public.backend_trigger(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_sp2_safetyprop_ptr_id_6057ecb9_fk_backend_safetyprop_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_sp2
    ADD CONSTRAINT backend_sp2_safetyprop_ptr_id_6057ecb9_fk_backend_safetyprop_id FOREIGN KEY (safetyprop_ptr_id) REFERENCES public.backend_safetyprop(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_sp2_state_id_01caf21d_fk_backend_trigger_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_sp2
    ADD CONSTRAINT backend_sp2_state_id_01caf21d_fk_backend_trigger_id FOREIGN KEY (state_id) REFERENCES public.backend_trigger(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_sp3_conds_sp3_id_f2c1fec5_fk_backend_s; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_sp3_conds
    ADD CONSTRAINT backend_sp3_conds_sp3_id_f2c1fec5_fk_backend_s FOREIGN KEY (sp3_id) REFERENCES public.backend_sp3(safetyprop_ptr_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_sp3_conds_trigger_id_4aa9489f_fk_backend_trigger_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_sp3_conds
    ADD CONSTRAINT backend_sp3_conds_trigger_id_4aa9489f_fk_backend_trigger_id FOREIGN KEY (trigger_id) REFERENCES public.backend_trigger(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_sp3_event_id_b133fd92_fk_backend_trigger_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_sp3
    ADD CONSTRAINT backend_sp3_event_id_b133fd92_fk_backend_trigger_id FOREIGN KEY (event_id) REFERENCES public.backend_trigger(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_sp3_safetyprop_ptr_id_ac7404ea_fk_backend_safetyprop_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_sp3
    ADD CONSTRAINT backend_sp3_safetyprop_ptr_id_ac7404ea_fk_backend_safetyprop_id FOREIGN KEY (safetyprop_ptr_id) REFERENCES public.backend_safetyprop(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_ssrule_action_id_6626b087_fk_backend_state_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_ssrule
    ADD CONSTRAINT backend_ssrule_action_id_6626b087_fk_backend_state_id FOREIGN KEY (action_id) REFERENCES public.backend_state(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_ssrule_rule_ptr_id_bb3cd0da_fk_backend_rule_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_ssrule
    ADD CONSTRAINT backend_ssrule_rule_ptr_id_bb3cd0da_fk_backend_rule_id FOREIGN KEY (rule_ptr_id) REFERENCES public.backend_rule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_state_cap_id_25727ebe_fk_backend_capability_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_state
    ADD CONSTRAINT backend_state_cap_id_25727ebe_fk_backend_capability_id FOREIGN KEY (cap_id) REFERENCES public.backend_capability(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_state_chan_id_b9d0a0d4_fk_backend_channel_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_state
    ADD CONSTRAINT backend_state_chan_id_b9d0a0d4_fk_backend_channel_id FOREIGN KEY (chan_id) REFERENCES public.backend_channel(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_state_dev_id_a376fae0_fk_backend_device_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_state
    ADD CONSTRAINT backend_state_dev_id_a376fae0_fk_backend_device_id FOREIGN KEY (dev_id) REFERENCES public.backend_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_statelog_cap_id_a554767b_fk_backend_capability_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_statelog
    ADD CONSTRAINT backend_statelog_cap_id_a554767b_fk_backend_capability_id FOREIGN KEY (cap_id) REFERENCES public.backend_capability(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_statelog_dev_id_63f7e345_fk_backend_device_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_statelog
    ADD CONSTRAINT backend_statelog_dev_id_63f7e345_fk_backend_device_id FOREIGN KEY (dev_id) REFERENCES public.backend_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_statelog_param_id_ab9f8aa5_fk_backend_parameter_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_statelog
    ADD CONSTRAINT backend_statelog_param_id_ab9f8aa5_fk_backend_parameter_id FOREIGN KEY (param_id) REFERENCES public.backend_parameter(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_timeparam_parameter_ptr_id_fc36e993_fk_backend_p; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_timeparam
    ADD CONSTRAINT backend_timeparam_parameter_ptr_id_fc36e993_fk_backend_p FOREIGN KEY (parameter_ptr_id) REFERENCES public.backend_parameter(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_trigger_cap_id_c28ac690_fk_backend_capability_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_trigger
    ADD CONSTRAINT backend_trigger_cap_id_c28ac690_fk_backend_capability_id FOREIGN KEY (cap_id) REFERENCES public.backend_capability(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_trigger_chan_id_bbc8de39_fk_backend_channel_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_trigger
    ADD CONSTRAINT backend_trigger_chan_id_bbc8de39_fk_backend_channel_id FOREIGN KEY (chan_id) REFERENCES public.backend_channel(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: backend_trigger_dev_id_4a2e1853_fk_backend_device_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backend_trigger
    ADD CONSTRAINT backend_trigger_dev_id_4a2e1853_fk_backend_device_id FOREIGN KEY (dev_id) REFERENCES public.backend_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

