


function validateSignUpForm() {
    const username = document.getElementById("username").value;
    const password = document.getElementById("password").value;

    if (username === "" || password === "") {
        alert("Username and password cannot be empty.");
        return false;
    }
    return true;
}

function validateLoginForm() {
    const username = document.getElementById("username").value;
    const password = document.getElementById("password").value;
    const feedback = document.getElementById("feedback");

    if (username === "" || password === "") {
        feedback.style.display = "block";
        feedback.textContent = "Username and password cannot be empty.";
        return false;
    }

    feedback.style.display = "none";
    return true;
}


function validateRequestForm() {
    const software = document.getElementById("software").value;
    const accessType = document.getElementById("accessType").value;
    const reason = document.getElementById("reason").value;

    if (software === "") {
        alert("Please select a software.");
        return false;
    }

    if (accessType === "") {
        alert("Please select an access type.");
        return false;
    }

    if (reason.trim() === "") {
        alert("Please provide a reason for your request.");
        return false;
    }

    return true;
}


function submitApproval(requestId, action) {
    fetch(`/UserAccessManagement/ApprovalServlet`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: new URLSearchParams({
            requestId: requestId,
            action: action
        })
    })
    .then(response => {
        if (response.ok) {
            const message = action === 'approve' ? 'Request approved successfully!' : 'Request rejected successfully!';
            showSnackbar(message, 'success');

            const row = document.querySelector(`#row-${requestId}`);
            if (row) {
                row.remove();
            } else {
                console.warn(`Row with id #row-${requestId} not found.`);
            }
        } else {
            showSnackbar('Failed to process the request. Please try again.', 'error');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        showSnackbar('An error occurred. Please try again later.', 'error');
    });
}




function validateSoftwareForm() {
    const name = document.getElementById('name').value;
    const description = document.getElementById('description').value;
    const checkboxes = document.querySelectorAll('input[name="access_levels"]:checked');

    if (name.trim() === "" || description.trim() === "") {
        alert("Software name and description are required.");
        return false;
    }

    if (checkboxes.length === 0) {
        alert("Please select at least one access level.");
        return false;
    }

    return true; 
}





