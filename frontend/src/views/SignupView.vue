<script setup>
  import { zodResolver } from "@primevue/forms/resolvers/zod";
  import { z } from "zod";

  import { Form } from "@primevue/forms";
  import InputText from "primevue/inputtext";
  import Password from "primevue/password";
  import Button from "primevue/button";
  import Message from "primevue/message";

  const initialValues = {
    organizationName: "",
    email: "",
    password: "",
    passwordConfirmation: "",
  };

  const resolver = zodResolver(
    z
      .object({
        organizationName: z.string().min(1, "Organization name is required."),
        email: z.email("Enter a valid email."),
        password: z.string().min(8, "Password must be at least 8 characters."),
        passwordConfirmation: z.string().min(1, "Confirm your password."),
      })
      .refine((data) => data.password === data.passwordConfirmation, {
        message: "Passwords do not match",
        path: ["passwordConfirmation"],
      })
  );

  // TODO
  async function onSubmit({ valid, values }) {}
</script>

<template>
  <main 
    class="
      min-h-screen flex flex-col justify-center max-w-md mx-auto px-6 pt-8 pb-56
    "
  >
    <Form
      v-slot="$form"
      :initial-values="initialValues"
      :resolver="resolver"
      @submit="onSubmit"
      class="space-y-4"
    >
      <img
        src="/text-logo.png"
        alt="Proto"
        class="mb-10 h-24 w-auto mx-auto block"
      />

      <h1 class="text-[22px] font-medium">
        Create your organization and account.
      </h1>

      <div>
        <label for="organizationName">Organization name</label>
        <InputText id="organizationName" name="organizationName" fluid />
        <Message
          v-if="$form.organizationName?.invalid"
          severity="error"
          size="small"
          variant="simple"
        >
          {{ $form.organizationName.error.message }}
        </Message>
      </div>

      <div>
        <label for="email">Email</label>
        <InputText id="email" name="email" type="email" fluid />
        <Message
          v-if="$form.email?.invalid"
          severity="error"
          size="small"
          variant="simple"
        >
          {{ $form.email.error.message }}
        </Message>
      </div>

      <div>
        <label for="password">Password</label>
        <Password
          id="password"
          name="password"
          toggleMask
          :feedback="false"
          fluid
        />
        <Message
          v-if="$form.password?.invalid"
          severity="error"
          size="small"
          variant="simple"
        >
          {{ $form.password.error.message }}
        </Message>
      </div>

      <div>
        <label for="passwordConfirmation">Confirm password</label>
        <Password
          id="passwordConfirmation"
          name="passwordConfirmation"
          toggleMask
          :feedback="false"
          fluid
        />
        <Message
          v-if="$form.passwordConfirmation?.invalid"
          severity="error"
          size="small"
          variant="simple"
        >
          {{ $form.passwordConfirmation.error.message }}
        </Message>
      </div>

      <Button
        type="submit"
        label="Create"
        fluid
      />

      <!--TODO -- perhaps have UI for server errors, success, and loading
      submission-->
    </Form>
  </main>
</template>