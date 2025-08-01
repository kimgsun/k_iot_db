# l_트랜잭션 > c_트랜잭션

/*
	사원이 회원가입 - 대기 중 
    인사 관리자가 회원가입 승인 - 대기 중 상태 > 승인 상태로 변경 
	회원가입 전체 완료 

	@Override
    @Transactional
    public ResponseDto<EmployeeSignUpApprovalsResponseDto> updateApproval(Long EmployeeId, EmployeeSignUpApprovalRequestDto dto, String loginId) {
        EmployeeListResponseDto responseDto = null;
        EmployeeSignUpApproval employeeSignUpApproval = null;
        Employee employee = null;

		# ====== 해당 직원 번호의 데이터가 존재하는 지 확인 ====== #
        employee = employeeRepository.findById(EmployeeId)
            .filter(emp -> emp.getIsApproved() == IsApproved.PENDING)
            .orElseThrow(() -> new IllegalArgumentException("회원가입 승인 대기중인 사원이 아닙니다."));

		# ====== 해당 직원 번호의 데이터가 '승인 대기 중'인지 확인 ====== #
        employeeSignUpApproval = employeeSignUpApprovalRepository.findAllByEmployeeIdAndIsApproved(employee, IsApproved.PENDING)
            .orElseThrow(() -> new IllegalArgumentException("회원가입 승인 대기 상태인 사원이 없습니다."));

		# ====== 대기 상태를 변경할 수 있는 권한을 가진 관리자인지 확인 ====== #
        Employee authorizerEmployee = employeeRepository.findByLoginId(loginId)
            .orElseThrow(() -> new IllegalArgumentException("관리자를 찾을 수 없습니다."));

		# ====== 조건에 따라 승인 상태를 변경 ====== #
		: 승인과 거부 상태를 저장
        if (dto.getIsApproved().equals(IsApproved.APPROVED) && dto.getDeniedReason().isBlank()) {
        
			# employee 직원 상태 - 승인으로 변경
            employee.setIsApproved(dto.getIsApproved());
            
            # 직원 승인 상태를 기록으로 저장 
            employeeSignUpApproval.setAuthorizerId(authorizerEmployee);
            employeeSignUpApproval.setIsApproved(dto.getIsApproved());
            
            >> 두 객체에 대한 save()가 동시에 이루어지지 않으면 데이터 무결성 위반 >> 트랜잭션 실행 (되돌리기)
            
        } else if (dto.getIsApproved().equals(IsApproved.DENIED) && !dto.getDeniedReason().isBlank()) {
            employee.setIsApproved(dto.getIsApproved());
            
            employeeSignUpApproval.setAuthorizerId(authorizerEmployee);
            employeeSignUpApproval.setIsApproved(dto.getIsApproved());
            employeeSignUpApproval.setDeniedReason(dto.getDeniedReason());
        } else {
            throw new IllegalArgumentException();
        }

        employeeRepository.save(employee);
        employeeSignUpApprovalRepository.save(employeeSignUpApproval);

        return ResponseDto.success(ResponseCode.SUCCESS, ResponseMessageKorean.SUCCESS, null);
    }
    
    >> 두 개 이상의 객체에 save() 저장이 이뤄지고 이들 간에 원자성을 보장해야한다면 트랜잭션이 반드시 필요!!!
*/