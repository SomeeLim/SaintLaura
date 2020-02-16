package ysl.member.model;

/*
   VO(Value Object) 또는 DTO(Data Transfer Object) 생성하기   
*/
public class MemberVO {

	private int idx;             // 회원번호(시퀀스로 데이터가 들어온다)
	private String email;        // 이메일    (AES-256 암호화/복호화 대상  양방향암호화)
	private String name;         // 회원명
	private String pwd;          // 비밀번호 (SHA-256 암호화 대상  단방향암호화)
	private String hp1;          // 휴대폰
	private String hp2;          //       (AES-256 암호화/복호화 대상    양방향암호화)
	private String hp3;          //       (AES-256 암호화/복호화 대상    양방향암호화)
	private String post;        // 우편번호
	private String addr1;        // 주소
	private String addr2;
	private String gender;       // 성별     여자 : 1 / 남자 : 2
	private String birthyyyy;    // 생년
	private String birthmm;      // 생월
	private String birthdd;      // 생일
	private int age;
	private String registerday;  // 가입일자
	private int status;          // 회원탈퇴유무   1:사용가능(가입중) / 0:사용불능(탈퇴) 
	
	private String lastLoginDate;     // 마지막으로 로그인 한 날짜시간 기록용
	private String lastPwdChangeDate; // 마지막으로 암호를 변경한 날짜시간 기록용
	
	private boolean requirePwdChange = false; 
	// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 6개월이 지났으면 true
	// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 6개월이 지나지 않았으면 false 
	
	private boolean idleStatus = false;  // 휴면유무(휴면이 아니라면 false, 휴면이면  true)
	// 마지막으로 로그인 한 날짜시간이 현재시각으로 부터 1년이 지났으면 true(휴면으로 지정)
	// 마지막으로 로그인 한 날짜시간이 현재시각으로 부터 1년이 지나지 않았으면 false 
	
	private String clientip; // 클라이언트의 IP 주소
	
	public MemberVO() { }
	
	public MemberVO(int idx, String email, String pwd, String name, String hp1, String hp2, String hp3,
			String post, String addr1, String addr2, String gender, String birthyyyy, String birthmm,
			String birthdd, int age, String registerday, int status, String lastLoginDate,
			String lastPwdChangeDate, boolean requirePwdChange, boolean idleStatus, String clientip) {
		super();
		this.idx = idx;
		this.email = email;
		this.pwd = pwd;
		this.name = name;
		this.hp1 = hp1;
		this.hp2 = hp2;
		this.hp3 = hp3;
		this.post = post;
		this.addr1 = addr1;
		this.addr2 = addr2;
		this.gender = gender;
		this.birthyyyy = birthyyyy;
		this.birthmm = birthmm;
		this.birthdd = birthdd;
		this.age = age;
		this.registerday = registerday;
		this.status = status;
		this.lastLoginDate = lastLoginDate;
		this.lastPwdChangeDate = lastPwdChangeDate;
		this.requirePwdChange = requirePwdChange;
		this.idleStatus = idleStatus;
		this.clientip = clientip;
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getHp1() {
		return hp1;
	}

	public void setHp1(String hp1) {
		this.hp1 = hp1;
	}

	public String getHp2() {
		return hp2;
	}

	public void setHp2(String hp2) {
		this.hp2 = hp2;
	}

	public String getHp3() {
		return hp3;
	}

	public void setHp3(String hp3) {
		this.hp3 = hp3;
	}

	public String getPost() {
		return post;
	}

	public void setPost(String post) {
		this.post = post;
	}

	public String getAddr1() {
		return addr1;
	}

	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}

	public String getAddr2() {
		return addr2;
	}

	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}

	public String getGender() {
		if("1".equals(gender))
			return "남성";
		else
			return "여성";
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getBirthyyyy() {
		return birthyyyy;
	}

	public void setBirthyyyy(String birthyyyy) {
		this.birthyyyy = birthyyyy;
	}

	public String getBirthmm() {
		return birthmm;
	}

	public void setBirthmm(String birthmm) {
		this.birthmm = birthmm;
	}

	public String getBirthdd() {
		return birthdd;
	}

	public void setBirthdd(String birthdd) {
		this.birthdd = birthdd;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}
	
	public String getRegisterday() {
		return registerday;
	}

	public void setRegisterday(String registerday) {
		this.registerday = registerday;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
	
	public String getLastLoginDate() {
		return lastLoginDate;
	}

	public void setLastLoginDate(String lastLoginDate) {
		this.lastLoginDate = lastLoginDate;
	}

	public String getLastPwdChangeDate() {
		return lastPwdChangeDate;
	}

	public void setLastPwdChangeDate(String lastPwdChangeDate) {
		this.lastPwdChangeDate = lastPwdChangeDate;
	}

	public boolean isRequirePwdChange() {
		return requirePwdChange;
	}

	public void setRequirePwdChange(boolean requirePwdChange) {
		this.requirePwdChange = requirePwdChange;
	}

	public boolean isIdleStatus() {
		return idleStatus;
	}

	public void setIdleStatus(boolean idleStatus) {
		this.idleStatus = idleStatus;
	}

	public String getClientip() {
		return clientip;
	}

	public void setClientip(String clientip) {
		this.clientip = clientip;
	}
	
	
	/////////////////////////////////////////////////////////
	public String getAllHp() {
		return hp1+"-"+hp2+"-"+hp3;
	}
	
	public String getAllPost() {
		return post;
	}
	
	public String getAllAddr() {
		return addr1+"-"+addr2;
	}
		   
	public String getBirthday() {
		return birthyyyy+"-"+birthmm+"-"+birthdd;
	}
	
}
